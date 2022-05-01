import 'package:flutter/material.dart';
import 'package:sglh/views/notifications/notifications_page.dart';

import '../notifications/geolocations_page.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  bool _toggleRecomendations = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Configurações",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsPage(),
                  ),
                );
              },
              child: const ListTile(
                title: Text('Notificações'),
                subtitle: Text(
                  'Realize a gestão de suas próximas marcações de ponto',
                ),
                leading: Icon(Icons.notifications),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GeolocationPage(),
                  ),
                );
              },
              child: const ListTile(
                title: Text(
                  'Meu local de trabalho',
                ),
                subtitle: Text(
                  'Defina seu local de trabalho no mapa para receber uma notificação ao chegar e sair do trabalho!',
                ),
                leading: Icon(Icons.location_on),
                trailing: Icon(Icons.edit),
              ),
            ),
            const Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              selectedTileColor: Colors.black,
              title: const Text(
                'Receber notificações baseadas no meu histórico de marcações',
              ),
              subtitle: const Text(
                'Habilite para receber notificações no horário que você '
                'está acostumado a marcar seu ponto',
              ),
              secondary: const Icon(Icons.history),
              onChanged: (value) {
                setState(() {
                  _toggleRecomendations = value;
                });
              },
              value: _toggleRecomendations,
            ),
          ],
        ),
      ),
    );
  }
}
