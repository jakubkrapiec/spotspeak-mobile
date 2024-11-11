import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/update_password_dto.dart';
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

  bool obscureText1 = true;
  bool obscureText2 = true;
  bool obscureText3 = true;

  Future<void> _changePassword(String currentPassword, String newPassword) async {
    try {
      await _userService.userRepo.updatePassword(UpdatePasswordDto(currentPassword, newPassword));
    } catch (exception) {
      await Fluttertoast.showToast(
        msg: 'W trakcie zmiany hasła wystąpił błąd: $exception',
        toastLength: Toast.LENGTH_LONG,
      );
    }

    await _userService.syncUser();
    if (!context.mounted) return;
    Navigator.of(context).pop();
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
            Text('Stare hasło:'),
            Gap(8),
            TextFormField(
              obscureText: obscureText1,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                }
                return null;
              },
              onSaved: (value) {
                newPassword = value;
              },
              decoration: InputDecoration(
                fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
                suffixIcon: IconButton(
                  icon: Icon(obscureText2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Musisz wpisać tekst';
                }
                return null;
              },
              onSaved: (value) {
                newPasswordRepeat = value;
              },
              decoration: InputDecoration(
                fillColor: MediaQuery.platformBrightnessOf(context) == Brightness.dark ? CustomColors.grey6 : null,
                suffixIcon: IconButton(
                  icon: Icon(obscureText3 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText3 = !obscureText3;
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
                      );
                      return;
                    }
                    await _changePassword(oldPassword!, newPassword!);
                    await Fluttertoast.showToast(
                      msg: 'Hasło zostało prawidłowo zmienione',
                      toastLength: Toast.LENGTH_LONG,
                    );
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
