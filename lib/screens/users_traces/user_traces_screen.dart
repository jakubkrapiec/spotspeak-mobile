import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/new_trace_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/screens/users_traces/trace_tile.dart';
import 'package:spotspeak_mobile/services/app_service.dart';
import 'package:spotspeak_mobile/services/location_service.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';
import 'package:spotspeak_mobile/theme/theme.dart';

enum SortingType {
  defaultType,
  oldestFirst,
  newestFirst,
  closestFirst,
  farthestFirst,
}

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
  List<Trace> traces = [];
  List<Trace> _originalTraces = [];
  Position? currentLocation;
  SortingType _currentSorting = SortingType.defaultType;

  Future<List<Trace>> _getTraces() async {
    final traces = await _traceService.getMyTraces();
    return traces;
  }

  Future<Position> _getCurrentLocation() async {
    final currentLocation = await _locationService.getCurrentLocation();
    return currentLocation;
  }

  void _openTraceDialog(int traceId) {
    final trace = traces.firstWhere((t) => t.id == traceId);
    showDialog<TraceDialogResult?>(
      context: context,
      builder: (context) => TraceDialog(trace: trace),
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    traces = await _getTraces();
    currentLocation = await _getCurrentLocation();
    _originalTraces = List.from(traces);
    setState(() {});
    if (widget.traceId != null) {
      _openTraceDialog(widget.traceId!);
    }
  }

  void _applySorting() {
    switch (_currentSorting) {
      case SortingType.oldestFirst:
        traces.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      case SortingType.newestFirst:
        traces.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      case SortingType.closestFirst:
        if (currentLocation != null) {
          final currentLatLng = LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          );
          traces.sort((a, b) => a.calculateDistance(currentLatLng).compareTo(b.calculateDistance(currentLatLng)));
        }

      case SortingType.farthestFirst:
        if (currentLocation != null) {
          final currentLatLng = LatLng(
            currentLocation!.latitude,
            currentLocation!.longitude,
          );
          traces.sort(
            (a, b) => b.calculateDistance(currentLatLng).compareTo(a.calculateDistance(currentLatLng)),
          );
        }

      case SortingType.defaultType:
        traces = List.from(_originalTraces);
    }
  }

  void _onSortingSelected(SortingType sortingType) {
    setState(() {
      _currentSorting = sortingType;
      _applySorting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dodane ślady'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: traces.isEmpty || currentLocation == null
            ? Center(child: CircularProgressIndicator())
            : Column(
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
                          onSelected: _onSortingSelected,
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
                    'Całkowita liczba śladów: ${traces.length}',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  Gap(8),
                  Divider(),
                  Gap(16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: traces.length,
                      itemBuilder: (context, index) {
                        return TraceTile(
                          trace: traces[index],
                          currentLocation: currentLocation!,
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
