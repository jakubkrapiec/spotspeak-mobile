import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/screens/users_traces/trace_tile.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

enum SortingType {
  defaultType,
  oldestFirst,
  newestFirst,
  closestFirst,
  farthestFirst,
}

@RoutePage()
class UserTracesScreen extends StatelessWidget {
  UserTracesScreen({super.key});

  final _appService = getIt<AppService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodane ślady'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: _appService.isDarkMode(context)
                        ? CustomTheme.darkContainerStyle
                        : CustomTheme.lightContainerStyle,
                    child: Text(
                      'Twoje dodane ślady:',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Gap(16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: _appService.isDarkMode(context)
                      ? CustomTheme.darkContainerStyle
                      : CustomTheme.lightContainerStyle,
                  child: PopupMenuButton(
                    onSelected: (sortingType) {},
                    itemBuilder: generatePopupItems,
                    child: Icon(
                      Icons.filter_list,
                      size: 36,
                    ),
                  ),
                ),
              ],
            ),
            Gap(16),
            Text(
              'Całkowita liczba śladów: 5',
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            Gap(8),
            Divider(),
            Gap(16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return TraceTile(
                    isActive: index / 2 != 2,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<PopupMenuItem<SortingType>> generatePopupItems(BuildContext context) {
  final preparedWidgets = <PopupMenuItem<SortingType>>[];

  for (final sortType in SortingType.values) {
    String text;

    switch (sortType) {
      case SortingType.oldestFirst:
        text = 'Od najstarszego';
      case SortingType.newestFirst:
        text = 'Od najnowszego';
      case SortingType.closestFirst:
        text = 'Od najbliższego';
      case SortingType.farthestFirst:
        text = 'Od najdalszego';
      case SortingType.defaultType:
        text = 'Domyślnie';
    }

    preparedWidgets.add(
      PopupMenuItem(
        value: sortType,
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }

  return preparedWidgets;
}
