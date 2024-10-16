import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

@RoutePage()
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/default_icon.jpg',
          ),
        ),
        Text('Username', style: Theme.of(context).textTheme.bodyLarge),
        Text('2137 pkt', style: Theme.of(context).textTheme.bodySmall),
        ProfileButton(pressFunction: () {}, buttonText: 'Informacje o koncie'),
        ProfileButton(pressFunction: () {}, buttonText: 'Lista znajomych'),
        ProfileButton(pressFunction: () {}, buttonText: 'Dodane ślady'),
        ProfileButton(pressFunction: () {}, buttonText: 'Ustawienia konta'),
        ProfileButton(pressFunction: () {}, buttonText: 'Ustawienia aplikacji'),
        TextButton(
          child: Text('Wyloguj się', style: Theme.of(context).textTheme.labelMedium),
          onPressed: () {},
        ),
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({required this.pressFunction, required this.buttonText, super.key});

  final VoidCallback pressFunction;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressFunction,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: MediaQuery.platformBrightnessOf(context) == Brightness.light ? CustomColors.blue3 : CustomColors.grey6,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
