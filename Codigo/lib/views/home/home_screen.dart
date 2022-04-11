import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:sglh/stores/auth_store.dart';
import 'package:sglh/stores/month_labor_time_store.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/hours_management/hours_report_information.dart';
import 'package:super_tooltip/super_tooltip.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SuperTooltip? tooltip;
  final AuthStore userManagerStore = GetIt.I<AuthStore>();
  final PageStore pageStore = GetIt.I<PageStore>();
  final MonthLaborTimeStore monthLaborTimeStore =
      GetIt.I<MonthLaborTimeStore>();

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip!.isOpen) {
      tooltip!.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip!.isOpen) {
      tooltip!.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox?;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      popupDirection: TooltipDirection.up,
      // arrowTipDistance: 15.0,
      // arrowBaseWidth: 40.0,
      // arrowLength: 40.0,
      // borderColor: Colors.green,
      // borderWidth: 5.0,
      //
      // snapsFarAwayVertically: true,
      // showCloseButton: ShowCloseButton.inside,
      // hasShadow: false,
      // touchThrougArea: Rect.fromLTWH(targetGlobalCenter.dx - 100,
      //     targetGlobalCenter.dy - 100, 200.0, 160.0),
      touchThroughAreaShape: ClipAreaShape.rectangle,
      content: const Material(
          child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Text(
          "HL - Total de Horas Lançadas\n\nTH - Horas a trabalhar até hoje\n\n"
          "SA - Saldo atual\n\nTM - Horas a trabalhar no mês\n\n"
          "SM - Saldo do mês\n\nBH - Banco de horas\n",
          softWrap: true,
        ),
      )),
    );

    // Wrap(
    //   crossAxisAlignment: WrapCrossAlignment.start,
    //   children: [
    //     ExpansionTile(
    //       backgroundColor: Colors.blueGrey[100],
    //       childrenPadding: const EdgeInsets.all(8),
    //       tilePadding: const EdgeInsets.all(16),
    //       controlAffinity: ListTileControlAffinity.leading,
    //       title: const Icon(Icons.help),
    //       children: const <Widget>[
    //         Text(
    //           ',
    //         ),
    //         Text(
    //           '',
    //         ),
    //         Text(
    //           '',
    //         ),
    //         Text(
    //           '',
    //         ),
    //         Text(
    //           '',
    //         ),
    //         Text(
    //           '',
    //         ),
    //       ],
    //     ),
    //
    //   ],
    // ),

    tooltip!.show(context);
  }

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
                builder: (context) =>
                    userManagerStore.isLoggedIn && monthLaborTimeStore != null
                        ? GridView(
                            clipBehavior: Clip.none,
                            // padding: const EdgeInsets.all(1),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            shrinkWrap: true,
                            children: [
                              HoursReportInformation(
                                value: monthLaborTimeStore.totalHoursClocked
                                    .toStringAsPrecision(2),
                                label: 'HL',
                              ),
                              HoursReportInformation(
                                value: monthLaborTimeStore.getHoursToWork
                                    .toStringAsPrecision(2),
                                label: 'TH',
                              ),
                              HoursReportInformation(
                                  value:
                                      '${monthLaborTimeStore.currentBalance.round()}',
                                  label: 'SA'),
                              HoursReportInformation(
                                  value:
                                      '${monthLaborTimeStore.hoursToWorkThisMonth.round()}',
                                  label: 'TM'),
                              HoursReportInformation(
                                  value: '${monthLaborTimeStore.monthBalance}',
                                  label: 'SM'),
                              const HoursReportInformation(
                                value: '0',
                                label: 'BH',
                              ),
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
          WillPopScope(
            child: GestureDetector(
              onTap: onTap,
              child: const Icon(Icons.help),
            ),
            onWillPop: _willPopCallback,
          )
        ],
      ),
    );
  }
}
