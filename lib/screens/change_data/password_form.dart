import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _userService = getIt<UserService>();
  final _appService = getIt<AppService>();

  bool _obscureText1 = true;
  bool _obscureText2 = true;
  bool _obscureText3 = true;

  Future<void> _changePassword(String currentPassword, String newPassword) async {
    try {
      await _userService.userRepo.updatePassword(UpdatePasswordDto(currentPassword, newPassword));
    } catch (exception) {
      if (exception is DioException) {
        // ignore: avoid_dynamic_calls
        if ((exception.response?.data?['message'] as List).cast<String>().firstOrNull == 'Invalid current password') {
          await Fluttertoast.showToast(
            msg: 'W trakcie zmiany hasła wystąpił błąd, podano nieprawidłowe aktualne hasło konta',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: CustomColors.grey1,
            textColor: CustomColors.grey6,
          );
        } else {
          await Fluttertoast.showToast(
            // ignore: avoid_dynamic_calls
            msg: 'W trakcie zmiany hasła wystąpił błąd: ${exception.response?.data?['message']}',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: CustomColors.grey1,
            textColor: CustomColors.grey6,
          );
        }
      } else {
        await Fluttertoast.showToast(
          msg: 'W trakcie zmiany hasła wystąpił błąd: $exception',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: CustomColors.grey1,
          textColor: CustomColors.grey6,
        );
      }

      return;
    }

    await _userService.syncUser();
    if (!mounted) return;
    Navigator.of(context).pop();

    await Fluttertoast.showToast(
      msg: 'Hasło zostało prawidłowo zmienione',
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: CustomColors.grey1,
      textColor: CustomColors.grey6,
    );
  }

  @override
  Widget build(BuildContext context) {
    String? oldPassword;
    String? newPassword;
    String? newPasswordRepeat;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aktualne hasło:'),
            Gap(8),
            TextFormField(
              obscureText: _obscureText1,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać aktualne hasło';
                }
                return null;
              },
              onSaved: (value) {
                oldPassword = value;
              },
              decoration: InputDecoration(
                fillColor: _appService.themeMode == ThemeMode.dark ? CustomColors.grey6 : null,
                suffixIcon: GestureDetector(
                  child: Icon(_obscureText1 ? Icons.visibility_off : Icons.visibility),
                  onTap: () {
                    setState(() {
                      _obscureText1 = !_obscureText1;
                    });
                  },
                ),
              ),
            ),
            Gap(16),
            Text('Nowe hasło:'),
            Gap(8),
            TextFormField(
              obscureText: _obscureText2,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                const passwordPattern = r'^[A-Za-z\d@$!%*?&]*$';
                final passwordRegex = RegExp(passwordPattern);

                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                } else if (!passwordRegex.hasMatch(value)) {
                  return 'Hasło zawiera niedozwolone znaki';
                }
                return null;
              },
              onSaved: (value) {
                newPassword = value;
              },
              decoration: InputDecoration(
                fillColor: _appService.themeMode == ThemeMode.dark ? CustomColors.grey6 : null,
                suffixIcon: IconButton(
                  icon: Icon(_obscureText2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText2 = !_obscureText2;
                    });
                  },
                ),
              ),
            ),
            Gap(16),
            Text('Powtórz hasło:'),
            Gap(8),
            TextFormField(
              obscureText: _obscureText3,
              style: TextStyle(fontSize: 22),
              validator: (value) {
                const passwordPattern = r'^[A-Za-z\d@$!%*?&]*$';
                final passwordRegex = RegExp(passwordPattern);

                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                } else if (!passwordRegex.hasMatch(value)) {
                  return 'Hasło zawiera niedozwolone znaki';
                }
                return null;
              },
              onSaved: (value) {
                newPasswordRepeat = value;
              },
              decoration: InputDecoration(
                fillColor: _appService.themeMode == ThemeMode.dark ? CustomColors.grey6 : null,
                suffixIcon: IconButton(
                  icon: Icon(_obscureText3 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _obscureText3 = !_obscureText3;
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
                    if (newPassword != newPasswordRepeat) {
                      await Fluttertoast.showToast(
                        msg: 'Nowe hasło i powtórzone hasło nie są takie same',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: CustomColors.grey1,
                        textColor: CustomColors.grey6,
                      );
                      return;
                    }
                    await _changePassword(oldPassword!, newPassword!);
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
