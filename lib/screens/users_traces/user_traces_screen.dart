import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/extensions/position_extensions.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_type.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/users_traces/trace_tile.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

enum _SortingType { defaultType, oldestFirst, newestFirst, closestFirst, farthestFirst }

@RoutePage()
class UserTracesScreen extends StatefulWidget {
  const UserTracesScreen({@QueryParam('traceId') this.traceId, super.key});

  final int? traceId;
  @override
  State<UserTracesScreen> createState() => _UserTracesScreenState();
}

class _UserTracesScreenState extends State<UserTracesScreen> {
  final _appService = getIt<AppService>();

  final _traceService = getIt<TraceService>();
  final _locationService = getIt<LocationService>();
  List<Trace> _traces = [];
  List<Trace> _originalTraces = [];
  Position? _currentLocation;
  _SortingType _currentSorting = _SortingType.defaultType;

  Future<List<Trace>> _getTraces() async {
    final traces = await _traceService.getMyTraces();
    return traces;
  }

  Future<Position> _getCurrentLocation() async {
    final currentLocation = await _locationService.getCurrentLocation();
    return currentLocation;
  }

  Future<void> _openTraceDialog(int traceId) async {
    final trace = _traces.firstWhere((t) => t.id == traceId);
    final shouldDelete = await showDialog<bool>(
          context: context,
          builder: (context) => TraceDialog(trace: trace),
        ) ??
        false;
    if (shouldDelete) {
      await _traceService.deleteTrace(traceId);
      setState(() {
        _traces.removeWhere((t) => t.id == traceId);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    _traces = await _getTraces();
    _currentLocation = await _getCurrentLocation();
    _originalTraces = List.from(_traces);
    setState(() {});
    if (widget.traceId != null) {
      unawaited(_openTraceDialog(widget.traceId!));
    }
  }

  void _applySorting() {
    switch (_currentSorting) {
      case _SortingType.oldestFirst:
        _traces.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      case _SortingType.newestFirst:
        _traces.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case _SortingType.closestFirst:
        if (_currentLocation != null) {
          final currentLatLng = _currentLocation!.toLatLng();
          _traces.sort((a, b) => a.calculateDistance(currentLatLng).compareTo(b.calculateDistance(currentLatLng)));
        }
      case _SortingType.farthestFirst:
        if (_currentLocation != null) {
          final currentLatLng = _currentLocation!.toLatLng();
          _traces.sort(
            (a, b) => b.calculateDistance(currentLatLng).compareTo(a.calculateDistance(currentLatLng)),
          );
        }
      case _SortingType.defaultType:
        _traces = List.from(_originalTraces);
    }
  }

  void _onSortingSelected(_SortingType sortingType) {
    setState(() {
      _currentSorting = sortingType;
      _applySorting();
    });
  }

  String _getDiscoveredTraceIconPath(TraceType type) => switch (type) {
        TraceType.text => 'assets/trace_icons_discovered/text_trace.svg',
        TraceType.image => 'assets/trace_icons_discovered/photo_trace.svg',
        TraceType.video => 'assets/trace_icons_discovered/video_trace.svg',
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodane ślady')),
      body: _traces.isEmpty || _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverGap(16),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Gap(16),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16),
                          decoration: _appService.isDarkMode(context)
                              ? CustomTheme.darkContainerStyle
                              : CustomTheme.lightContainerStyle,
                          child: Text(
                            'Twoje dodane ślady:',
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Gap(16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: _appService.isDarkMode(context)
                            ? CustomTheme.darkContainerStyle
                            : CustomTheme.lightContainerStyle,
                        child: PopupMenuButton(
                          onSelected: _onSortingSelected,
                          itemBuilder: _generatePopupItems,
                          child: Icon(Icons.filter_list, size: 30),
                        ),
                      ),
                      Gap(16),
                    ],
                  ),
                ),
                SliverGap(16),
                SliverToBoxAdapter(
                  child: Text(
                    'Całkowita liczba śladów: ${_traces.length}',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SliverGap(8),
                SliverToBoxAdapter(child: Divider()),
                const SliverGap(16),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverList.separated(
                    itemCount: _traces.length,
                    itemBuilder: (context, index) => TraceTile(
                      trace: _traces[index],
                      currentLocation: _currentLocation!,
                      traceIconPath: _getDiscoveredTraceIconPath(_traces[index].type),
                      onTap: () => _openTraceDialog(_traces[index].id),
                    ),
                    separatorBuilder: (context, index) => Gap(8),
                  ),
                ),
                const SliverGap(16),
              ],
            ),
    );
  }
}

List<PopupMenuItem<_SortingType>> _generatePopupItems(BuildContext context) {
  final preparedWidgets = <PopupMenuItem<_SortingType>>[];

  for (final sortType in _SortingType.values) {
    final text = switch (sortType) {
      _SortingType.oldestFirst => 'Od najstarszego',
      _SortingType.newestFirst => 'Od najnowszego',
      _SortingType.closestFirst => 'Od najbliższego',
      _SortingType.farthestFirst => 'Od najdalszego',
      _SortingType.defaultType => 'Domyślnie',
    };

    preparedWidgets.add(
      PopupMenuItem(
        value: sortType,
        child: Text(text, style: Theme.of(context).textTheme.labelSmall),
      ),
    );
  }

  return preparedWidgets;
}
