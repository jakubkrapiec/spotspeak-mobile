import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/edit_user_dto.dart';
import 'package:spotspeak_mobile/repositories/user_repository.dart';
import 'package:spotspeak_mobile/screens/change_data/change_account_data_screen.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
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

  bool _obscureText = true;

  final _userService = getIt<UserService>();
  final _authService = getIt<AuthenticationService>();
  final _appService = getIt<AppService>();

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
                  backgroundColor: CustomColors.grey1,
                  textColor: CustomColors.grey6,
                )
              : await Fluttertoast.showToast(
                  msg: 'Użytkownik o podanym adresie email już istnieje',
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: CustomColors.grey1,
                  textColor: CustomColors.grey6,
                );
          return;
        }

        await _userService.syncUser();
        await Fluttertoast.showToast(
          msg: 'Dane zostały poprawnie zmienione',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: CustomColors.grey1,
          textColor: CustomColors.grey6,
        );

        if (!mounted) return;
        Navigator.of(context).pop();
      case PasswordChallengeFailedWrongPassword _:
        await Fluttertoast.showToast(
          msg: 'Wprowadzono niepoprawne hasło, dane nie zostały zmienione',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: CustomColors.grey1,
          textColor: CustomColors.grey6,
        );
      case PasswordChallengeFailedOtherError _:
        await Fluttertoast.showToast(
          msg: 'Wystąpił błąd, dane nie zostały zmienione',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: CustomColors.grey1,
          textColor: CustomColors.grey6,
        );
    }
  }

  bool _validateData(String newData, AccountData dataType) {
    final user = _userService.user.value;
    if (dataType == AccountData.email) {
      return user.email != newData;
    } else {
      return user.username != newData;
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
                const emailPattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                final emailRegex = RegExp(emailPattern);

                const nicknamePattern = r'^[a-zA-Z0-9._-]+$';
                final nicknameRegex = RegExp(nicknamePattern);

                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                } else if (widget.formType == AccountData.email && !emailRegex.hasMatch(value)) {
                  return 'Nieprawidłowy adres email';
                } else if (widget.formType == AccountData.username && !nicknameRegex.hasMatch(value)) {
                  return 'Nieprawidłowa nazwa użytkownika';
                }
                return null;
              },
              onSaved: (value) {
                _newValue = value;
              },
              decoration: _appService.themeMode == ThemeMode.dark
                  ? InputDecoration(
                      fillColor: CustomColors.grey6,
                    )
                  : null,
            ),
            Gap(16),
            if (_authService.userTypeNotifier.value != UserType.google)
              Column(
                children: [
                  Text('Potwierdź hasło:'),
                  Gap(8),
                  TextFormField(
                    obscureText: _obscureText,
                    style: TextStyle(fontSize: 22),
                    validator: (value) {
                      if (_authService.userTypeNotifier.value == UserType.google) {
                        return null;
                      }
                      if (value == null || value.isEmpty) {
                        return 'Musisz wpisać hasło';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                    decoration: InputDecoration(
                      fillColor: _appService.themeMode == ThemeMode.dark ? CustomColors.grey6 : null,
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            Gap(16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (!_validateData(_newValue!, widget.formType)) {
                      await Fluttertoast.showToast(
                        msg: 'Wpisywana wartość musi być inna niż aktualna',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: CustomColors.grey1,
                        textColor: CustomColors.grey6,
                      );
                      return;
                    }
                    if (_authService.userTypeNotifier.value == UserType.google) {
                      await _changeData('', _newValue!, widget.formType);
                    } else {
                      await _changeData(_password!, _newValue!, widget.formType);
                    }
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
