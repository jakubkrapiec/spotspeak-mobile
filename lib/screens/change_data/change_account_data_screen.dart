import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

enum AccountData {
  email,
  username,
  password,
}

@RoutePage()
class ChangeAccountDataScreen extends StatefulWidget {
  const ChangeAccountDataScreen({required this.accountData, super.key});

  final AccountData accountData;

  @override
  State<ChangeAccountDataScreen> createState() => _ChangeAccountDataScreenState();
}

class _ChangeAccountDataScreenState extends State<ChangeAccountDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.accountData == AccountData.username
              ? 'Zmiana nazwy użytkownika'
              : widget.accountData == AccountData.email
                  ? 'Zmiana adresu email'
                  : 'Zmiana hasła',
        ),
      ),
      body: widget.accountData == AccountData.password
          ? PasswordForm()
          : widget.accountData == AccountData.username
              ? UsernameEmailForm(
                  formType: 'Nazwa użytkownika:',
                  initValue: 'username',
                )
              : UsernameEmailForm(
                  formType: 'Adres email:',
                  initValue: 'email',
                ),
    );
  }
}

class UsernameEmailForm extends StatelessWidget {
  const UsernameEmailForm({required this.formType, required this.initValue, super.key});

  final String formType;
  final String initValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(formType),
          Gap(8),
          TextFormField(
            initialValue: initValue,
            style: TextStyle(fontSize: 22),
            decoration: MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? InputDecoration(
                    fillColor: CustomColors.grey6,
                  )
                : null,
          ),
          Gap(16),
          Text('Potwierdź hasło:'),
          Gap(8),
          TextFormField(
            obscureText: true,
            style: TextStyle(fontSize: 22),
            decoration: MediaQuery.platformBrightnessOf(context) == Brightness.dark
                ? InputDecoration(
                    fillColor: CustomColors.grey6,
                  )
                : null,
          ),
          Gap(16),
          Center(child: ElevatedButton(onPressed: () {}, child: Text('Zatwierdź'))),
        ],
      ),
    );
  }
}

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stare hasło:'),
          Gap(8),
          TextFormField(
            obscureText: obscureText1,
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
              suffixIcon: GestureDetector(
                child: Icon(obscureText1 ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    obscureText1 = !obscureText1;
                  });
                },
              ),
            ),
          ),
          Gap(16),
          Text('Nowe hasło:'),
          Gap(8),
          TextFormField(
            obscureText: obscureText2,
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
              suffixIcon: GestureDetector(
                child: Icon(obscureText2 ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    obscureText2 = !obscureText2;
                  });
                },
              ),
            ),
          ),
          Gap(16),
          Text('Powtórz hasło:'),
          Gap(8),
          TextFormField(
            obscureText: obscureText3,
            style: TextStyle(fontSize: 22),
            decoration: InputDecoration(
              fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
              suffixIcon: GestureDetector(
                child: Icon(obscureText3 ? Icons.visibility_off : Icons.visibility),
                onTap: () {
                  setState(() {
                    obscureText3 = !obscureText3;
                  });
                },
              ),
            ),
          ),
          Gap(16),
          Center(child: ElevatedButton(onPressed: () {}, child: Text('Zatwierdź'))),
        ],
      ),
    );
  }
}
