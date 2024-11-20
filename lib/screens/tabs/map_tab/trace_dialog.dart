import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spotspeak_mobile/common/widgets/spotspeak_dialog.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/trace_media.dart';
import 'package:spotspeak_mobile/services/comment_service.dart';
import 'package:timeago/timeago.dart' as timeago;

class TraceDialog extends StatefulWidget {
  const TraceDialog({required this.trace, super.key});

  final Trace trace;

  @override
  State<TraceDialog> createState() => _TraceDialogState();
}

class _TraceDialogState extends State<TraceDialog> {
  late final TextEditingController _commentController;
  final _commentService = getIt<CommentService>();
  late List<Comment> _comments = widget.trace.comments;
  bool _commentButtonLoading = false;

  @override
  void initState() {
    _commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _onAddComment() async {
    final content = _commentController.text;
    if (content.isEmpty) return;
    try {
      final comment = await _commentService.addCommentToTrace(
        traceId: widget.trace.id,
        addCommentDto: AddCommentDto(content),
      );
      if (!mounted) return;
      setState(() {
        _comments.add(comment);
        _commentController.clear();
      });
    } catch (e, st) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nie udało się dodać komentarza')));
      debugPrint('Failed to add comment: $e\n$st');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpotSpeakDialog(
      title: 'Ślad',
      children: [
        Row(
          children: [
            Text('Autor:'),
            Gap(8),
            if (widget.trace.author.profilePictureUrl != null) ...[
              ClipOval(
                child: CachedNetworkImage(
                  width: 32,
                  height: 32,
                  imageUrl: widget.trace.author.profilePictureUrl!,
                ),
              ),
              Gap(8),
            ],
            Text(widget.trace.author.username),
          ],
        ),
        const Gap(8),
        Align(alignment: Alignment.centerLeft, child: Text(timeago.format(widget.trace.createdAt, locale: 'pl'))),
        const Gap(8),
        Text(
          widget.trace.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        if (widget.trace.resourceAccessUrl != null) ...[
          const Gap(8),
          TraceMedia(mediaUrl: widget.trace.resourceAccessUrl!, type: widget.trace.type),
        ],
        const Gap(8),
        Align(alignment: Alignment.centerLeft, child: Text('Komentarze')),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Text(_comments[index].content),
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: _comments.length,
        ),
        const Gap(8),
        TextFormField(
          controller: _commentController,
          style: Theme.of(context).textTheme.bodySmall,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) => _onAddComment(),
          decoration: InputDecoration(
            hintText: 'Dodaj komentarz',
            suffixIcon: ListenableBuilder(
              listenable: _commentController,
              builder: (context, child) => AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _commentController.text.isEmpty ? const SizedBox.shrink() : child,
              ),
              child: _commentButtonLoading
                  ? const SizedBox.square(
                      dimension: 32,
                      child: CircularProgressIndicator(),
                    )
                  : IconButton(onPressed: _onAddComment, icon: Icon(Icons.send)),
            ),
          ),
        ),
      ],
    );
  }
}
