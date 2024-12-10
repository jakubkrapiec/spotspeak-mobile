import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotspeak_mobile/common/widgets/spotspeak_dialog.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/trace_media_thumbnail.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

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

  String? _errorMessage;

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
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpotSpeakDialog(
      title: 'Nowy ślad',
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            key: ValueKey('trace_text_field'),
            controller: _descriptionController,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3,
            maxLength: 140,
            decoration: InputDecoration(hintText: 'Opisz swój ślad'),
          ),
        ),
        if (_media == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () async {
                  try {
                    final result = await _picker.pickImage(source: ImageSource.camera);
                    if (result == null || !mounted) return;
                    _setMediaFile(result.path);
                  } on PlatformException catch (e) {
                    if (e.code == 'camera_access_denied') {
                      await Fluttertoast.showToast(
                        msg: 'Aplikacja nie ma dostępu do aparatu',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: CustomColors.grey1,
                        textColor: CustomColors.grey6,
                      );
                    }
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.video_call),
                onPressed: () async {
                  try {
                    final result = await _picker.pickVideo(
                      source: ImageSource.camera,
                      maxDuration: const Duration(seconds: 10),
                    );
                    if (result == null || !mounted) return;
                    _setMediaFile(result.path);
                  } on PlatformException catch (e) {
                    if (e.code == 'camera_access_denied') {
                      await Fluttertoast.showToast(
                        msg: 'Aplikacja nie ma dostępu do aparatu',
                        toastLength: Toast.LENGTH_LONG,
                        backgroundColor: CustomColors.grey1,
                        textColor: CustomColors.grey6,
                      );
                    }
                  }
                },
                iconSize: 32,
              ),
            ],
          )
        else
          TraceMediaThumbnail(
            media: _media!,
            onRemove: () => setState(() => _media = null),
          ),
        const Gap(16),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _errorMessage == null
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      _errorMessage!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: CustomColors.red1),
                    ),
                  ),
                ),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;
            if (_descriptionController.text.isEmpty && _media == null) {
              setState(() => _errorMessage = 'Dodaj opis lub media');
              return;
            }
            final result = TraceDialogResult(_descriptionController.text, _media);
            Navigator.of(context).pop(result);
          },
          child: Text('Dodaj ślad'),
        ),
      ],
    );
  }
}

class TraceDialogResult {
  const TraceDialogResult(this.description, this.media);

  final String description;
  final File? media;
}
