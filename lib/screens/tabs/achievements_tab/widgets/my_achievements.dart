import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/achievement_container.dart';
import 'package:spotspeak_mobile/common/widgets/loading_error.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/achievement.dart';
import 'package:spotspeak_mobile/services/achievement_service.dart';

class MyAchievements extends StatefulWidget {
  const MyAchievements({required this.refreshStream, super.key});

  final Stream<void> refreshStream;

  @override
  State<MyAchievements> createState() => _MyAchievementsState();
}

class _MyAchievementsState extends State<MyAchievements> {
  final _achievementService = getIt<AchievementService>();

  List<Achievement>? _achievements;
  List<Achievement> _achievementsFiltered = [];
  LoadingStatus _status = LoadingStatus.loading;
  bool _showOnlyNonCompletedAchievements = false;

  late final StreamSubscription<void> _refreshSubscription;

  @override
  void initState() {
    super.initState();
    _refreshSubscription = widget.refreshStream.listen((_) {
      _getAchievements();
    });
  }

  @override
  void dispose() {
    _refreshSubscription.cancel();
    super.dispose();
  }

  Future<void> _getAchievements() async {
    setState(() {
      _status = LoadingStatus.loading;
    });
    try {
      final achievements = await _achievementService.getMyAchievements();
      setState(() {
        _achievements = achievements;
        _filterAchievements(_showOnlyNonCompletedAchievements);
        _status = LoadingStatus.loaded;
      });
    } catch (e, st) {
      debugPrint('$e\n$st');
      if (mounted) {
        setState(() {
          _status = LoadingStatus.error;
        });
      }
    }
  }

  void _filterAchievements(bool onlyNonCompleted) {
    if (onlyNonCompleted) {
      _achievementsFiltered = List.from(_achievements?.where((a) => a.completedAt == null) ?? []);
    } else {
      _achievementsFiltered = List.from(_achievements ?? []);
      _sortAchievements();
    }
  }

  void _sortAchievements() {
    _achievementsFiltered.sort((a, b) {
      if (a.completedAt != null && b.completedAt == null) return -1;
      if (a.completedAt == null && b.completedAt != null) return 1;
      return 0;
    });
  }

  final _autoSizeGroup = AutoSizeGroup();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Twoje osiągnięcia', style: TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              onPressed: () {
                setState(() {
                  _showOnlyNonCompletedAchievements = !_showOnlyNonCompletedAchievements;
                  _filterAchievements(_showOnlyNonCompletedAchievements);
                });
              },
              icon: Icon(
                _showOnlyNonCompletedAchievements ? Icons.visibility_off : Icons.visibility,
                size: 28,
              ),
            ),
          ],
        ),
        const Gap(16),
        switch (_status) {
          LoadingStatus.loading => Padding(
              padding: const EdgeInsets.symmetric(vertical: 64),
              child: Center(child: const CircularProgressIndicator()),
            ),
          LoadingStatus.error => LoadingError(onRetry: _getAchievements),
          LoadingStatus.loaded => GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemBuilder: (context, index) => AchievementContainer(
                achievement: _achievementsFiltered[index],
                autoSizeGroup: _autoSizeGroup,
              ),
              itemCount: _achievementsFiltered.length,
              shrinkWrap: true,
            ),
        },
      ],
    );
  }
}
