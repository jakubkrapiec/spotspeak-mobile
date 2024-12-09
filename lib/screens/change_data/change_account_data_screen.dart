import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/user.dart';
import 'package:spotspeak_mobile/screens/account_settings/change_password_web_view.dart';
import 'package:spotspeak_mobile/screens/change_data/username_email_form.dart';
import 'package:spotspeak_mobile/services/user_service.dart';

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
  State<ChangeAccountDataScreen> createState() =>
      _ChangeAccountDataScreenState();
}

class _ChangeAccountDataScreenState extends State<ChangeAccountDataScreen> {
  final _userService = getIt<UserService>();

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
      body: StreamBuilder<User>(
        stream: _userService.user,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return SizedBox();
          return widget.accountData == AccountData.password
              ? ChangePasswordWebView()
              : widget.accountData == AccountData.username
                  ? UsernameEmailForm(
                      formType: widget.accountData,
                      initValue: snapshot.data?.username ?? 'Nieznany',
                    )
                  : UsernameEmailForm(
                      formType: widget.accountData,
                      initValue: snapshot.data?.email ?? 'Nieznany email',
                    );
        },
      ),
    );
  }
}
