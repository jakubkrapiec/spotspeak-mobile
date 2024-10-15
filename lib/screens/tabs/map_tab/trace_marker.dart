import 'package:flutter/material.dart';

class TraceMarker extends StatelessWidget {
  const TraceMarker({super.key});

  static const dimens = 12.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      width: dimens,
      height: dimens,
    );
  }
}
