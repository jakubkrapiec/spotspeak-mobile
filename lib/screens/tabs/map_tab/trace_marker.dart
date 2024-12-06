import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/models/trace_location.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/trace_dialog.dart';
import 'package:spotspeak_mobile/services/trace_service.dart';

class TraceMarker extends StatefulWidget {
  const TraceMarker({required this.trace, required this.currentUserLocation, required this.onRefreshTraces, super.key});

  final TraceLocation trace;
  final LatLng? currentUserLocation;
  final VoidCallback onRefreshTraces;

  static const dimens = 42.0;

  @override
  State<TraceMarker> createState() => _TraceMarkerState();
}

class _TraceMarkerState extends State<TraceMarker> {
  bool _isLoading = false;
  final _traceService = getIt<TraceService>();

  Future<void> _onTapTrace() async {
    if (widget.currentUserLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Twoja lokalizacja nie jest dostępna')));
      return;
    }
    setState(() => _isLoading = true);
    try {
      final Trace trace;
      if (widget.trace.hasDiscovered) {
        trace = await _traceService.getTrace(widget.trace.id);
      } else {
        trace = await _traceService.discoverTrace(
          widget.trace.id,
          widget.currentUserLocation!.longitude,
          widget.currentUserLocation!.latitude,
        );
      }
      if (!mounted) return;
      setState(() => _isLoading = false);
      final shouldDelete = await showDialog<bool>(context: context, builder: (context) => TraceDialog(trace: trace));
      if (shouldDelete ?? false) {
        await _traceService.deleteTrace(widget.trace.id);
      }
      widget.onRefreshTraces();
    } catch (e, st) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Podejdź bliżej do śladu')));
        debugPrint('Failed to load trace: $e\n$st');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _isLoading ? null : _onTapTrace,
      child: _isLoading
          ? SizedBox.square(dimension: TraceMarker.dimens, child: const CircularProgressIndicator())
          : SvgPicture.asset(
              width: TraceMarker.dimens,
              height: TraceMarker.dimens,
              theme: SvgTheme(currentColor: Theme.of(context).primaryColor),
              widget.trace.iconSvgPath,
            ),
    );
  }
}
