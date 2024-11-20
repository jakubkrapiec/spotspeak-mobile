import 'package:flutter/material.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

class FriendsSearch extends StatelessWidget {
  FriendsSearch({
    required this.pressFunction,
    super.key,
  });

  final _appService = getIt<AppService>();

  final void Function(String val) pressFunction;
  @override
  Widget build(BuildContext context) {
    var textPattern = '';
    return ColoredBox(
      color: _appService.isDarkMode(context) ? CustomColors.grey5 : CustomColors.blue1,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Container(
          decoration:
              _appService.isDarkMode(context) ? CustomTheme.darkContainerStyle : CustomTheme.lightContainerStyle,
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Wyszukaj znajomego',
                  ),
                  onChanged: (value) => {textPattern = value},
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(
                  Icons.search,
                ),
                onPressed: () {
                  pressFunction(textPattern);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
