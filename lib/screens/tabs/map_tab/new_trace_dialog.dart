import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class NewTraceDialog extends StatefulWidget {
  const NewTraceDialog({super.key});

  @override
  State<NewTraceDialog> createState() => _NewTraceDialogState();
}

class _NewTraceDialogState extends State<NewTraceDialog> {
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Opacity(
                  opacity: 0,
                  child: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.close),
                  ),
                ),
                Text('Nowy ślad'),
                IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _descriptionController,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 3,
                maxLength: 140,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                final result = TraceDialogResult(_descriptionController.text, null);
                Navigator.of(context).pop(result);
              },
              child: Text('Dodaj ślad'),
            ),
            const Gap(24),
          ],
        ),
      ),
    );
  }
}

class TraceDialogResult {
  const TraceDialogResult(this.description, this.media);

  final String description;
  final File? media;
}
