import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/models/hours_management/labor_time_model.dart';
import 'package:sglh/models/hours_management/time_period_model.dart';
import 'package:sglh/stores/month_labor_time_store.dart';
import 'package:sglh/views/components/utils/model_builder.dart';

class WorkHoursPage extends StatefulWidget {
  WorkHoursPage(
      {Key? key,
      required this.monthLaborTimeStore,
      required this.monthReference})
      : super(key: key);

  final MonthLaborTimeStore monthLaborTimeStore;
  String monthReference;

  @override
  _WorkHoursPageState createState() => _WorkHoursPageState();
}

class _WorkHoursPageState extends State<WorkHoursPage> {
  final List<ReactionDisposer> _disposers = [];

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  List<DataColumn> getColumns(List<String> columns) {
    final List fixedList = Iterable<int>.generate(columns.length).toList();
    return fixedList.map((index) {
      return DataColumn(
        label: Text(columns[index]),
        numeric: index == 2,
      );
    }).toList();
  }

  List<DataRow> getRows(LaborTime laborTime) {
    int numItems = laborTime.clockInList.length;

    List<DataRow> rowsList = List<DataRow>.generate(numItems, (index) {
      final TimePeriod clockIn = laborTime.clockInList[index];
      final cells = <String>[
        if (clockIn.startingTime != null)
          DateFormat.Hm().format(clockIn.startingTime!.toLocal())
        else
          '+',
        if (clockIn.endingTime != null)
          DateFormat.Hm().format(clockIn.endingTime!.toLocal())
        else if (clockIn.startingTime != null)
          '+'
        else
          '',
        if (clockIn.startingTime != null && clockIn.endingTime != null)
          '${clockIn.getHoursWorked()}'
        else
          '',
      ];
      return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          if (index.isEven) {
            return Colors.grey.withOpacity(0.3);
          }
          return null;
        }),
        cells: Utils.modelBuilder(cells, (columnIndex, cell) {
          return DataCell(
            Text('$cell'),
            showEditIcon: false,
            onLongPress: () {
              switch (columnIndex) {
                case 0:
                  removeTimePeriod(clockIn);
                  break;
                case 1:
                  removeEndingTime(clockIn);
                  break;
              }
            },
            onTap: () {
              switch (columnIndex) {
                case 0:
                  editStartinTime(clockIn);
                  break;
                case 1:
                  editEndingTime(clockIn);
                  break;
              }
            },
          );
        }),
      );
    });
    var emptyText = const Text("");
    if (rowsList.isEmpty ||
        (rowsList.isNotEmpty &&
            rowsList.last.cells.last.child.toString() !=
                emptyText.toString())) {
      final cells = <String>[
        '+',
        '',
        '',
      ];
      rowsList.add(DataRow(
        color: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          return Colors.grey.withOpacity(0.3);
        }),
        cells: Utils.modelBuilder(cells, (columnIndex, cell) {
          return DataCell(
            Text('$cell'),
            showEditIcon: false,
            onTap: () {
              addTimePeriod(laborTime);
            },
          );
        }),
      ));
    }
    return rowsList;
  }

  Future<void> addTimePeriod(LaborTime laborTime) async {
    final currentDateTime = DateTime.now();
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: TimeOfDay(
        hour: currentDateTime.hour,
        minute: currentDateTime.minute,
      ),
      context: context,
    );
    if (selectedTime != null) {
      DateTime startingTime = DateTime(
        currentDateTime.year,
        currentDateTime.month,
        currentDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      ).toUtc();

      DateTime? lastClockInEnd = widget.monthLaborTimeStore.lastClockingEnd;
      if (lastClockInEnd != null && startingTime.isBefore(lastClockInEnd)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O tempo de entrada após um intervalo não deve ser inferior '
              'ao tempo da última saída! Operação não realizada.',
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        TimePeriod timePeriod = TimePeriod(
          laborTimeId: laborTime.objectId,
          startingTime: startingTime,
          endingTime: null,
        );
        widget.monthLaborTimeStore.addTimePeriod(timePeriod);
      }
    }
  }

  Future editStartinTime(TimePeriod timePeriod) async {
    var currentDateTime = DateTime.now();
    if (timePeriod.startingTime != null) {
      currentDateTime = timePeriod.startingTime!.toLocal();
    }
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: TimeOfDay(
        hour: currentDateTime.hour,
        minute: currentDateTime.minute,
      ),
      context: context,
    );

    if (selectedTime != null) {
      DateTime startingTime = DateTime(
        timePeriod.startingTime?.year ?? currentDateTime.year,
        timePeriod.startingTime?.month ?? currentDateTime.month,
        timePeriod.startingTime?.day ?? currentDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      DateTime? lastClockInEnd =
          widget.monthLaborTimeStore.penultimateClockingEnd;
      if (lastClockInEnd != null && startingTime.isBefore(lastClockInEnd)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O tempo de entrada após um intervalo não deve ser inferior '
              'ao tempo da última saída! Operação não realizada.',
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        widget.monthLaborTimeStore
            .updateTimePeriodStartingTime(startingTime, timePeriod);
      }
    }
  }

  Future<void> editEndingTime(TimePeriod timePeriod) async {
    var currentDateTime = DateTime.now();
    if (timePeriod.endingTime != null) {
      currentDateTime = timePeriod.endingTime!.toLocal();
    }
    TimeOfDay? selectedTime = await showTimePicker(
      initialTime: TimeOfDay(
        hour: currentDateTime.hour,
        minute: currentDateTime.minute,
      ),
      context: context,
    );

    if (selectedTime != null) {
      DateTime endingTime = DateTime(
        timePeriod.endingTime?.year ?? currentDateTime.year,
        timePeriod.endingTime?.month ?? currentDateTime.month,
        timePeriod.endingTime?.day ?? currentDateTime.day,
        selectedTime.hour,
        selectedTime.minute,
      ).toUtc();

      DateTime? lastClockInStart = widget.monthLaborTimeStore.lastClockInStart;
      if (lastClockInStart != null && endingTime.isBefore(lastClockInStart)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O tempo de saída não deve ser inferir a um tempo de entrada! Operação não realizada.',
              style: TextStyle(
                  color: Colors.red, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        );
      } else {
        widget.monthLaborTimeStore
            .updateTimePeriodEndingTime(endingTime, timePeriod);
      }
    }
  }

  void removeEndingTime(TimePeriod clockIn) {
    if (clockIn.endingTime == null) {
      return;
    }
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: const Text("Apagar"),
      onPressed: () {
        widget.monthLaborTimeStore.removeEndingTime(clockIn);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Apagando lançamento de horas"),
      content: Text(
        "Essa ação apagará a saída ${clockIn.endingTime!.hour}:${clockIn.endingTime!.minute.toString().padLeft(2, '0')} "
        "do seu lançamento de horas do dia ${DateFormat.d().format(widget.monthLaborTimeStore.currentLaborTime!.date)}. \n\nConfirma exclusão?",
      ),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void removeTimePeriod(TimePeriod timePeriod) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancelar"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: const Text("Apagar"),
      onPressed: () async {
        if (timePeriod.objectId != null) {
          await widget.monthLaborTimeStore.deleteTimePeriod(timePeriod);
        }
        if (widget.monthLaborTimeStore.operationError == null) {
          widget.monthLaborTimeStore.removeTimePeriod(timePeriod);
        }
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Apagando lançamento de horas"),
      content: Text(
          "Essa ação apagará a entrada e saída do lançamento de horas. $timePeriod"),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool result = await widget.monthLaborTimeStore.saveData();
          if (widget.monthLaborTimeStore.operationError == null && result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Lançamento de horas salvo com sucesso!\n'
                  'Recarregando lançamentos...',
                  style: TextStyle(fontSize: 20),
                ),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: const Icon(
          Icons.more_time_outlined,
          color: Colors.black,
        ),
        backgroundColor: Colors.blueGrey[200],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.grey,
        ),
        child: Card(
          elevation: 8,
          // color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Observer(
            builder: (_) {
              switch (widget.monthLaborTimeStore.fetchReposFuture.status) {
                case FutureStatus.pending:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case FutureStatus.rejected:
                  return Column(
                    children: [
                      const Text(
                        "Ocorreu um erro ao obter os dados do registro de ponto.",
                      ),
                      ElevatedButton(
                        onPressed: widget.monthLaborTimeStore.fetchData,
                        child: const Text("Clique para tentar novamente"),
                      ),
                    ],
                  );
                case FutureStatus.fulfilled:
                  widget.monthLaborTimeStore.setCurrentMonthLaborTime(
                      widget.monthLaborTimeStore.fetchReposFuture.value);
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          widget.monthReference,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Expanded(
                        child: GridView(
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          children: List<Observer>.generate(
                            31,
                            (i) {
                              return Observer(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () => widget.monthLaborTimeStore
                                      .setChosenDay(i + 1),
                                  style: ButtonStyle(
                                    backgroundColor: i + 1 ==
                                            widget.monthLaborTimeStore.chosenDay
                                        ? MaterialStateProperty.all<Color>(
                                            Colors.black)
                                        : MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        side: BorderSide(
                                          width: 2,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '${i + 1}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: i + 1 ==
                                              widget
                                                  .monthLaborTimeStore.chosenDay
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ),
                      ),
                      Observer(
                        builder: (BuildContext context) {
                          if (widget.monthLaborTimeStore.currentLaborTime ==
                              null) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return DataTable(
                              rows: getRows(
                                  widget.monthLaborTimeStore.currentLaborTime!),
                              columns:
                                  getColumns(['Entrada', 'Saída', 'Total']),
                            );
                          }
                        },
                      ),
                    ],
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
