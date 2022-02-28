import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/components/home/hours_report_information.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthStore userManagerStore = GetIt.I<AuthStore>();
  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "Relatório consolidado de horas",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Center(
            heightFactor: 1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 8,
              margin: const EdgeInsets.all(16),
              child: Observer(
                builder: (context) => userManagerStore.isLoggedIn
                    ? GridView(
                        clipBehavior: Clip.none,
                        // padding: const EdgeInsets.all(1),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        shrinkWrap: true,
                        children: const [
                          HoursReportInformation(value: '0', label: 'HL'),
                          HoursReportInformation(value: '0', label: 'TH'),
                          HoursReportInformation(value: '0', label: 'SA'),
                          HoursReportInformation(value: '0', label: 'TM'),
                          HoursReportInformation(value: '0', label: 'SM'),
                          HoursReportInformation(value: '0', label: 'BH')
                        ],
                      )
                    : SizedBox(
                        width: 300,
                        height: 150,
                        child: Center(
                          child: Text(
                            "Realize login \npara visualizar\nseu relatório",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
