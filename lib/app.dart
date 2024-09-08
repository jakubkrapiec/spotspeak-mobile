import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/routing/app_router.dart';

class App extends StatelessWidget {
  App({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SpotSpeak',
      routerConfig: _router.config(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}
