import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';

class EventTraces extends StatelessWidget {
  const EventTraces({required this.traces, required this.userLocation, required this.onTapTrace, super.key});

  final List<TraceLocation> traces;
  final LatLng? userLocation;
  final Future<void> Function(TraceLocation) onTapTrace;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.sizeOf(context).width * 0.3,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final trace in traces)
              _TraceListEntry(
                trace: trace,
                userLocation: userLocation,
                onTapTrace: onTapTrace,
              ),
          ],
        ),
      ),
    );
  }
}

class _TraceListEntry extends StatefulWidget {
  _TraceListEntry({
    required this.trace,
    required this.userLocation,
    required this.onTapTrace,
  }) : super(key: ValueKey(trace.id));

  final TraceLocation trace;
  final LatLng? userLocation;
  final Future<void> Function(TraceLocation) onTapTrace;

  @override
  State<_TraceListEntry> createState() => _TraceListEntryState();
}

class _TraceListEntryState extends State<_TraceListEntry> {
  @override
  void initState() {
    super.initState();
    _updateDistance();
  }

  @override
  void didUpdateWidget(_TraceListEntry oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.userLocation != widget.userLocation) {
      _updateDistance();
    }
  }

  void _updateDistance() {
    if (widget.userLocation == null) {
      return;
    }
    final distance = Geolocator.distanceBetween(
      widget.trace.latitude.toDouble(),
      widget.trace.longitude.toDouble(),
      widget.userLocation!.latitude,
      widget.userLocation!.longitude,
    );
    setState(() {
      _currentDistance = distance.toInt();
    });
  }

  int? _currentDistance;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTapTrace(widget.trace),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              widget.trace.iconSvgPath,
              width: 24,
              height: 24,
              theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
            ),
            Text('${_currentDistance ?? '???'} m'),
          ],
        ),
      ),
    );
  }
}
