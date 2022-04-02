import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sglh/stores/page_store.dart';
import 'package:sglh/views/components/custom_drawer/page_tile.dart';

class PageSection extends StatelessWidget {
  PageSection({Key? key}) : super(key: key);

  final PageStore pageStore = GetIt.I<PageStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PageTile(
          label: 'Home',
          iconData: Icons.home_outlined,
          onTap: () {
            pageStore.setPage(0);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 0,
        ),
        PageTile(
          label: 'Lançamento de horas',
          iconData: Icons.watch_later_outlined,
          onTap: () {
            pageStore.setPage(1);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 1,
        ),
        PageTile(
          label: 'Histórico',
          iconData: Icons.history,
          onTap: () {
            pageStore.setPage(2);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 2,
        ),
        PageTile(
          label: 'Configurações',
          iconData: Icons.settings_outlined,
          onTap: () {
            pageStore.setPage(3);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 3,
        ),
        PageTile(
          label: 'Minha Conta',
          iconData: Icons.person_outline_outlined,
          onTap: () {
            pageStore.setPage(4);
            Navigator.of(context).pop();
          },
          highlighted: pageStore.page == 4,
        ),
      ],
    );
  }
}
