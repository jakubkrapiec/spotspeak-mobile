import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/models/event_location.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class EventMarker extends StatefulWidget {
  const EventMarker({required this.event, super.key});

  final EventLocation event;

  static const dimens = 136.0;

  @override
  State<EventMarker> createState() => _EventMarkerState();
}

class _EventMarkerState extends State<EventMarker> with SingleTickerProviderStateMixin {
  late final Timer _timer;
  static const _animationDuration = Duration(milliseconds: 1500);
  bool _isBig = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(_animationDuration, (_) {
      if (mounted) {
        setState(() {
          _isBig = !_isBig;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _onTapEvent() async {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: _animationDuration,
        curve: Curves.easeInOut,
        width: _isBig ? EventMarker.dimens : EventMarker.dimens * 0.85,
        height: _isBig ? EventMarker.dimens : EventMarker.dimens * 0.85,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: CustomColors.red1,
          boxShadow: [
            BoxShadow(
              color: CustomColors.red1.withOpacity(0.5),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(1000),
            onTap: _onTapEvent,
            child: SizedBox.square(
              dimension: EventMarker.dimens * 0.85,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.priority_high, color: Colors.white),
                    const Gap(8),
                    AutoSizeText(
                      widget.event.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                    Text(
                      '${widget.event.traces.length} śladów',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
