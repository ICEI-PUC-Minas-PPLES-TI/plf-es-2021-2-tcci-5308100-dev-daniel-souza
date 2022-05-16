import 'package:clock_in/models/hours_management/month_labor_time_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/models/hours_management/labor_time_model.dart';
import 'package:clock_in/models/hours_management/time_period_model.dart';
import 'package:clock_in/stores/month_labor_time_store.dart';
import 'package:clock_in/views/components/utils/model_builder.dart';

class WorkHoursPage extends StatefulWidget {
  const WorkHoursPage({
    Key? key,
    required this.monthLaborTime,
  }) : super(key: key);

  final MonthLaborTime monthLaborTime;

  @override
  _WorkHoursPageState createState() => _WorkHoursPageState();
}

class _WorkHoursPageState extends State<WorkHoursPage> {
  final List<ReactionDisposer> _disposers = [];
  final MonthLaborTimeStore monthLaborTimeStore =
      GetIt.I<MonthLaborTimeStore>();

  @override
  void initState() {
    monthLaborTimeStore.setMonthLaborTime(widget.monthLaborTime);
    print('monthLaborTimeStore.currentLaborTime');
    print(monthLaborTimeStore.currentLaborTime);
    super.initState();
  }

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

      DateTime? lastClockInEnd = monthLaborTimeStore.lastClockingEnd;
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
        monthLaborTimeStore.addTimePeriod(timePeriod);
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

      DateTime? lastClockInEnd = monthLaborTimeStore.penultimateClockingEnd;
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
        monthLaborTimeStore.updateTimePeriodStartingTime(
          startingTime,
          timePeriod,
        );
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

      DateTime? lastClockInStart = monthLaborTimeStore.lastClockInStart;
      if (lastClockInStart != null && endingTime.isBefore(lastClockInStart)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'O tempo de saída não deve ser inferior a um tempo de entrada! Operação não realizada.',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      } else {
        monthLaborTimeStore.updateTimePeriodEndingTime(
          endingTime,
          timePeriod,
        );
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
        monthLaborTimeStore.removeEndingTime(clockIn);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Apagando lançamento de horas"),
      content: Text(
        "Essa ação apagará a saída ${clockIn.endingTime!.hour}:${clockIn.endingTime!.minute.toString().padLeft(2, '0')} "
        "do seu lançamento de horas do dia ${DateFormat.d().format(monthLaborTimeStore.currentLaborTime!.date)}. \n\nConfirma exclusão?",
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
          await monthLaborTimeStore.deleteTimePeriod(timePeriod);
        }
        if (monthLaborTimeStore.operationError == null) {
          monthLaborTimeStore.removeTimePeriod(timePeriod);
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
      appBar: AppBar(
        title: Text(widget.monthLaborTime.monthReference!),
      ),
      floatingActionButton: SpeedDial(
          icon: Icons.add,
          backgroundColor: Colors.blueGrey[350],
          children: [
            SpeedDialChild(
              child: const Icon(Icons.punch_clock),
              label: 'Salvar marcações',
              backgroundColor: Colors.blueGrey[200],
              onTap: () async {
                bool result = await monthLaborTimeStore.saveData();
                if (monthLaborTimeStore.operationError == null && result) {
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
            ),
            SpeedDialChild(
              child: const Icon(Icons.email),
              label: 'Enviar para aprovação',
              backgroundColor: Colors.blueGrey[200],
              onTap: () async {
                await monthLaborTimeStore.sendToApproval(
                  monthLaborTimeStore.currentMonthLaborTime!,
                );
              },
            ),
          ]),
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
              switch (monthLaborTimeStore.fetchReposFuture.status) {
                case FutureStatus.pending:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case FutureStatus.rejected:
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Ocorreu um erro ao obter os dados do registro de ponto.",
                      ),
                      ElevatedButton(
                        onPressed: monthLaborTimeStore.fetchData,
                        child: const Text("Clique para tentar novamente"),
                      ),
                    ],
                  );
                case FutureStatus.fulfilled:
                  // get the firt day of month to calculate the days of week
                  int daysToAdd =
                      widget.monthLaborTime.laborTimeList.first.date.weekday;

                  // when the month starts on sunday, it should not add empty cells
                  if (daysToAdd == 7) {
                    daysToAdd = 0;
                  }

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Flexible(
                        flex: 2,
                        child: GridView(
                          padding: const EdgeInsets.all(5),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          children: List<Observer>.generate(
                            widget.monthLaborTime.laborTimeList.length +
                                daysToAdd,
                            (i) {
                              return Observer(builder: (context) {
                                return ElevatedButton(
                                  onPressed: () {
                                    if (i >= daysToAdd) {
                                      monthLaborTimeStore.setChosenDay(
                                        i + 1 - daysToAdd,
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor: i + 1 - daysToAdd ==
                                            monthLaborTimeStore.chosenDay
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
                                    i < daysToAdd ? '' : '${i + 1 - daysToAdd}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: i + 1 - daysToAdd ==
                                              monthLaborTimeStore.chosenDay
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
                      Expanded(
                        child: Observer(
                          builder: (BuildContext context) {
                            if (monthLaborTimeStore.currentLaborTime == null) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return SingleChildScrollView(
                                child: DataTable(
                                  rows: getRows(
                                      monthLaborTimeStore.currentLaborTime!),
                                  columns:
                                      getColumns(['Entrada', 'Saída', 'Total']),
                                ),
                              );
                            }
                          },
                        ),
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
