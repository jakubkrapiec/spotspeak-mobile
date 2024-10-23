import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum AppData {
  notifications,
  appTheme,
}

@RoutePage()
class ChangeAppDataScreen extends StatefulWidget {
  const ChangeAppDataScreen({required this.appData, super.key});

  final AppData appData;

  @override
  State<ChangeAppDataScreen> createState() => _ChangeAppDataScreenState();
}

class _ChangeAppDataScreenState extends State<ChangeAppDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appData == AppData.notifications ? 'Ustawienia powiadomień' : 'Ustawienia motywu'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: widget.appData == AppData.notifications ? NotificationsPanel() : AppThemePanel(),
      ),
    );
  }
}

class NotificationsPanel extends StatefulWidget {
  const NotificationsPanel({super.key});

  @override
  State<NotificationsPanel> createState() => _NotificationsPanelState();
}

class _NotificationsPanelState extends State<NotificationsPanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchPanel(panelTitle: 'Wszystie powiadomienia'),
        Gap(8),
        Divider(),
        Gap(32),
        SwitchPanel(panelTitle: 'Zdobycie osiągnięcia'),
        Gap(16),
        SwitchPanel(panelTitle: 'Zmiana miejsca w rankingu'),
        Gap(16),
        SwitchPanel(panelTitle: 'Komentarze do śladów'),
        Gap(16),
        SwitchPanel(panelTitle: 'Zaproszenia do znajomych'),
      ],
    );
  }
}

class AppThemePanel extends StatefulWidget {
  const AppThemePanel({super.key});

  @override
  State<AppThemePanel> createState() => _AppThemePanelState();
}

class _AppThemePanelState extends State<AppThemePanel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchPanel(
          panelTitle: 'Zgodnie z systemem',
        ),
        Gap(8),
        Divider(),
        Gap(32),
        SwitchPanel(
          panelTitle: 'Jasny motyw',
        ),
      ],
    );
  }
}

class SwitchPanel extends StatefulWidget {
  const SwitchPanel({required this.panelTitle, super.key});

  final String panelTitle;

  @override
  State<SwitchPanel> createState() => _SwitchPanelState();
}

class _SwitchPanelState extends State<SwitchPanel> {
  bool val = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.panelTitle),
        Switch(
          value: val,
          onChanged: (bool value) {
            setState(() {
              val = value;
            });
          },
        ),
      ],
    );
  }
}
