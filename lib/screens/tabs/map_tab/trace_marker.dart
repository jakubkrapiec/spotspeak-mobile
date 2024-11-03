import 'package:flutter/material.dart';

class TraceMarker extends StatelessWidget {
  const TraceMarker({super.key});

  static const dimens = 12.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset('assets/trace_icon_colored.png', width: dimens),
    );
  }
}
