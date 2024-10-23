import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart';
import 'package:spotspeak_mobile/screens/tabs/profile_tab/profile_button.dart';

@RoutePage()
class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacje o koncie'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Gap(32),
            Row(
              children: [
                SizedBox.square(
                  dimension: 100,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/default_icon.jpg',
                    ),
                  ),
                ),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Zdjęcie profilowe'),
                    Gap(8),
                    Text(
                      maxLines: 3,
                      'Format PNG lub JPG, maksymalny rozmiar 5MB',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            Gap(64),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.username));
              },
              buttonText: 'Zmiana nazwy użytkownika',
            ),
            Gap(16),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.email));
              },
              buttonText: 'Zmiana adresu email',
            ),
            Gap(16),
            ProfileButton(
              pressFunction: () {
                context.router.push(ChangeAccountDataRoute(accountData: AccountData.password));
              },
              buttonText: 'Zmiana hasła',
            ),
            Gap(16),
            ProfileButton(pressFunction: () {}, buttonText: 'Usunięcie konta'),
          ],
        ),
      ),
    );
  }
}


  // Row(
  //             children: [
  //               Text('Data założenia konta'),
  //               Gap(32),
  //               Text('21.10.2024 r.'),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text('Ilość zdobytych punktów:'),
  //               Gap(32),
  //               Text('2137 pkt.'),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text('Ilość dodanych śladów:'),
  //               Gap(32),
  //               Text('10'),
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text('Ilość zdobytych osiągnięć:'),
  //               Gap(32),
  //               Text('50'),
  //             ],
  //           ),









            //   Row(
            //   children: [
            //     Expanded(child: Text('Nazwa użytkownika')),
            //     Expanded(
            //       child: TextFormField(
            //         initialValue: 'username',
            //       ),
            //     ),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(child: Text('Adres email')),
            //     Expanded(child: TextFormField(initialValue: 'email',)),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(child: Text('Aktualne hasło')),
            //     Expanded(child: TextFormField(initialValue: 'username',)),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(child: Text('Nowe hasło')),
            //     Expanded(child: TextField()),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Expanded(child: Text('Powtórz hasło')),
            //     Expanded(child: TextField()),
            //   ],
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: Text('Aktualizuj'),
            // ),