import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sglh/models/hours_management/month_labor_time_model.dart';
import 'package:sglh/stores/month_labor_time_store.dart';
import 'package:sglh/stores/page_store.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key? key, required this.pageController}) : super(key: key);
  PageController pageController;
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
    TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
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
                List<MonthLaborTime> monthLaborTimeList =
                    monthLaborTimeStore.fetchReposFuture.value!;
                return ListView.builder(
                  itemCount: monthLaborTimeList.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      backgroundColor: Colors.blueGrey[100],
                      childrenPadding: const EdgeInsets.all(8),
                      tilePadding: const EdgeInsets.all(16),
                      trailing: GestureDetector(
                        onTap: () {
                          pageStore.setPage(1);
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
                        monthLaborTimeList[index].monthReference ?? "teste",
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
                            'Horas Lançadas: ${monthLaborTimeStore.totalHoursClocked}',
                            style: textStyle,
                          ),
                        ),
                        ListTile(
                            title: Text(
                          'Banco de horas: 0',
                          style: textStyle,
                        )),
                        ListTile(
                            title: Text(
                          'Horas a trabalhar até hoje: ${monthLaborTimeStore.getHoursToWork.round()}',
                          style: textStyle,
                        )),
                        ListTile(
                            title: Text(
                          'Horas a trabalhar no mês: ${monthLaborTimeStore.hoursToWorkThisMonth.round()}',
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
