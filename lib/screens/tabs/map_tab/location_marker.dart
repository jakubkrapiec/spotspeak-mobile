import 'package:flutter/material.dart';

class LocationMarker extends StatelessWidget {
  const LocationMarker({super.key});

  static const outerSize = 5.0;
  static const innerSize = 12.0;
  static const dimens = (outerSize * 2) + innerSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(outerSize),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue.withOpacity(0.4)),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue[700]),
        width: innerSize,
        height: innerSize,
      ),
    );
  }
}
