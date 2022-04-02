import 'package:flutter/material.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  bool _toggleNotifications = false;
  bool _toggleLocation = false;
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
            SwitchListTile(
              title: const Text('Receber notificações'),
              subtitle: const Text(
                'Habilita/Desabilita todos os tipos de notificação',
              ),
              secondary: const Icon(Icons.notifications),
              onChanged: (value) {
                setState(() {
                  _toggleNotifications = value;
                  if (!value) {
                    _toggleLocation = value;
                    _toggleRecomendations = value;
                  }
                });
              },
              value: _toggleNotifications,
            ),
            const Divider(
              thickness: 1.2,
            ),
            SwitchListTile(
              title: const Text(
                'Receber notificações para marcar ponto usando minha localização',
              ),
              subtitle: const Text(
                'Habilite para receber notificações ao chegar e sair do escritório',
              ),
              secondary: _toggleLocation
                  ? const Icon(Icons.location_on)
                  : const Icon(Icons.location_off),
              onChanged: (value) {
                setState(() {
                  _toggleLocation = value;
                });
              },
              value: _toggleLocation,
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
