import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class UsernameEmailForm extends StatefulWidget {
  const UsernameEmailForm({required this.formType, required this.initValue, super.key});

  final AccountData formType;
  final String initValue;

  @override
  State<UsernameEmailForm> createState() => _UsernameEmailFormState();
}

class _UsernameEmailFormState extends State<UsernameEmailForm> {
  final _formKey = GlobalKey<FormState>();

  String? _newValue;

  String? _password;

  bool obscureText = true;

  final _userService = getIt<UserService>();

  Future<void> _changeData(String currentPassword, String newData, AccountData dataType) async {
    final response = await _checkPassword(currentPassword);

    switch (response) {
      case final PasswordChallengeSuccess success:
        try {
          dataType == AccountData.username
              ? await _userService.userRepo
                  .updateUser(EditUserDto(passwordChallengeToken: success.token, username: newData))
              : await _userService.userRepo
                  .updateUser(EditUserDto(passwordChallengeToken: success.token, email: newData));
        } catch (exception) {
          dataType == AccountData.username
              ? await Fluttertoast.showToast(
                  msg: 'Użytkownik o podanej nazwie już istnieje',
                  toastLength: Toast.LENGTH_LONG,
                )
              : await Fluttertoast.showToast(
                  msg: 'Użytkownik o podanym adresie email już istnieje',
                  toastLength: Toast.LENGTH_LONG,
                );
          return;
        }

        await _userService.syncUser();
        await Fluttertoast.showToast(
          msg: 'Dane zostały poprawnie zmienione',
          toastLength: Toast.LENGTH_LONG,
        );
      case PasswordChallengeFailedWrongPassword _:
        await Fluttertoast.showToast(
          msg: 'Wprowadzono niepoprawne hasło, dane nie zostały zmienione',
          toastLength: Toast.LENGTH_LONG,
        );
      case PasswordChallengeFailedOtherError _:
        await Fluttertoast.showToast(
          msg: 'Wystąpił błąd, dane nie zostały zmienione',
          toastLength: Toast.LENGTH_LONG,
        );
    }
  }

  Future<PasswordChallengeResult> _checkPassword(String password) async {
    final result = await _userService.userRepo.checkPassword(password);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.formType == AccountData.email ? 'Adres email:' : 'Nazwa użytkownika'),
            Gap(8),
            TextFormField(
              initialValue: widget.initValue,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                }
                return null;
              },
              onSaved: (value) {
                _newValue = value;
              },
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
              obscureText: obscureText,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać hasło';
                }
                return null;
              },
              onSaved: (value) {
                _password = value;
              },
              decoration: InputDecoration(
                fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            Gap(16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    await _changeData(_password!, _newValue!, widget.formType);
                  }
                },
                child: Text('Zatwierdź'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
