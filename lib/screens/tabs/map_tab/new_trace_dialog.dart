import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/trace_media_thumbnail.dart';

class NewTraceDialog extends StatefulWidget {
  const NewTraceDialog({super.key});

  @override
  State<NewTraceDialog> createState() => _NewTraceDialogState();
}

class _NewTraceDialogState extends State<NewTraceDialog> {
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();
  File? _media;
  final _picker = ImagePicker();

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

  void _setMediaFile(String path) {
    final file = File(path);
    setState(() {
      _media = file;
    });
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
            if (_media == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      final result = await _picker.pickImage(source: ImageSource.camera);
                      if (result == null || !mounted) return;
                      _setMediaFile(result.path);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.video_call),
                    onPressed: () async {
                      final result = await _picker.pickVideo(source: ImageSource.camera);
                      if (result == null || !mounted) return;
                      _setMediaFile(result.path);
                    },
                    iconSize: 32,
                  ),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () async {
                      final result = await _picker.pickMedia();
                      if (result == null || !mounted) return;
                      _setMediaFile(result.path);
                    },
                  ),
                ],
              )
            else
              TraceMediaThumbnail(
                media: _media!,
                onRemove: () => setState(() => _media = null),
              ),
            const Gap(16),
            ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) return;
                final result = TraceDialogResult(_descriptionController.text, _media);
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
