import 'package:flutter/material.dart';

class SpotSpeakDialog extends StatelessWidget {
  const SpotSpeakDialog({required this.children, this.title, this.scrollController, this.action, super.key});

  final String? title;
  final List<Widget> children;
  final ScrollController? scrollController;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
      child: ListView(
        shrinkWrap: true,
        controller: scrollController,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0,
                child: Row(
                  children: [
                    if (action != null) action!,
                    IconButton(onPressed: null, icon: Icon(Icons.close)),
                  ],
                ),
              ),
              Text(title ?? ''),
              Row(
                children: [
                  if (action != null) action!,
                  IconButton(
                    onPressed: Navigator.of(context).pop,
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(mainAxisSize: MainAxisSize.min, children: children),
          ),
        ],
      ),
    );
  }
}
