import 'package:clock_in/views/hours_management/work_hours_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:clock_in/models/hours_management/month_labor_time_model.dart';
import 'package:clock_in/stores/month_labor_time_store.dart';
import 'package:clock_in/stores/page_store.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;
  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  PageStore pageStore = GetIt.I<PageStore>();
  MonthLaborTimeStore monthLaborTimeStore = GetIt.I<MonthLaborTimeStore>();

  @override
  void initState() {
    super.initState();
    reaction((_) => pageStore.page,
        (int page) => widget.pageController.jumpToPage(page));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(fontWeight: FontWeight.bold);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Histórico de lançamento de horas",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        Expanded(
          child: Observer(builder: (_) {
            switch (monthLaborTimeStore.fetchReposFuture.status) {
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
                      onPressed: monthLaborTimeStore.fetchData,
                      child: const Text("Clique para tentar novamente"),
                    ),
                  ],
                );
              case FutureStatus.fulfilled:
                if (monthLaborTimeStore.fetchReposFuture.value == null ||
                    monthLaborTimeStore.fetchReposFuture.value!.isEmpty) {
                  return const Text(
                    "Nenhum histórico para exibir...",
                  );
                }

                // sort the data by month and year int values in descending order
                // final List<MonthLaborTime> sortedData =

                List<MonthLaborTime> monthLaborTimeList =
                    monthLaborTimeStore.fetchReposFuture.value!.toList()
                      ..sort(
                        (MonthLaborTime a, MonthLaborTime b) {
                          final int aYear = a.year;
                          final int bYear = b.year;
                          if (aYear != bYear) {
                            return bYear - aYear;
                          }

                          final int aMonth = a.month;
                          final int bMonth = b.month;
                          if (aMonth != bMonth) {
                            return bMonth - aMonth;
                          }

                          return 0;
                        },
                      );
                // monthLaborTimeStore.fetchReposFuture.value!;

                return ListView.builder(
                  itemCount: monthLaborTimeList.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      backgroundColor: Colors.blueGrey[100],
                      childrenPadding: const EdgeInsets.all(8),
                      tilePadding: const EdgeInsets.all(16),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkHoursPage(
                                monthLaborTime: monthLaborTimeList[index],
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          monthLaborTimeList[index].status == "Em lançamento"
                              ? Icons.edit
                              : Icons.remove_red_eye_outlined,
                          size: 40,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Text(
                        monthLaborTimeList[index].monthReference ?? "06/2022",
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        monthLaborTimeList[index].status ?? "Em lançamento",
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            'Horas Lançadas: ${monthLaborTimeList[index].totalHoursClocked}',
                            style: textStyle,
                          ),
                        ),
                        ListTile(
                            title: Text(
                          'Horas a trabalhar até hoje: ${monthLaborTimeList[index].getHoursToWork.round()}',
                          style: textStyle,
                        )),
                        ListTile(
                            title: Text(
                          'Horas a trabalhar no mês: ${monthLaborTimeList[index].hoursToWorkThisMonth.round()}',
                          style: textStyle,
                        )),
                      ],
                    );
                  },
                );
            }
          }),
        ),
      ],
    );
  }
}
