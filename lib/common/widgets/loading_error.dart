import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LoadingError extends StatelessWidget {
  const LoadingError({required this.onRetry, this.title, super.key});

  final VoidCallback onRetry;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title ?? 'Wystąpił błąd'),
        const Gap(8),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('Spróbuj ponownie'),
        ),
      ],
    );
  }
}
