import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:spotspeak_mobile/common/widgets/spotspeak_dialog.dart';
import 'package:spotspeak_mobile/di/get_it.dart';
import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/models/content_author.dart';
import 'package:spotspeak_mobile/models/friendship.dart';
import 'package:spotspeak_mobile/models/trace.dart';
import 'package:spotspeak_mobile/routing/app_router.gr.dart';
import 'package:spotspeak_mobile/screens/tabs/map_tab/widgets/trace_media.dart';
import 'package:spotspeak_mobile/services/authentication_service.dart';
import 'package:spotspeak_mobile/services/comment_service.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';
import 'package:spotspeak_mobile/services/user_service.dart';
import 'package:spotspeak_mobile/theme/colors.dart';

class TraceDialog extends StatefulWidget {
  const TraceDialog({required this.trace, super.key});

  final Trace trace;

  @override
  State<TraceDialog> createState() => _TraceDialogState();
}

class _TraceDialogState extends State<TraceDialog> {
  late final TextEditingController _commentController;
  final _commentService = getIt<CommentService>();
  final _friendService = getIt<FriendService>();
  final _authService = getIt<AuthenticationService>();
  late final List<Comment> _comments = widget.trace.comments;
  List<Friendship> _friends = [];
  bool _commentButtonLoading = false;
  late final FocusNode _textFieldFocusNode;
  late final ScrollController _scrollController;

  List<ContentAuthor> _getMentionableProfiles() => <ContentAuthor>{
        ..._friends.map((f) => f.friendInfo),
        ..._comments.map((c) => c.author),
        widget.trace.author,
      }.toList();

  Future<void> _getFriends() async {
    final friends = await _friendService.getFriends();
    if (!mounted) return;
    setState(() {
      _friends = friends;
    });
  }

  List<String> _generateMentionsFromText(String text) {
    final mentions = <String>[];
    final mentionableProfiles = _getMentionableProfiles();
    final splitText = text.split(' ');
    for (final profile in mentionableProfiles) {
      for (final textFragment in splitText) {
        if (textFragment == '@${profile.username}') {
          mentions.add(profile.id);
          break;
        }
      }
    }
    return mentions;
  }

  @override
  void initState() {
    _commentController = TextEditingController();
    _textFieldFocusNode = FocusNode();
    _scrollController = ScrollController();
    _getFriends();
    super.initState();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _textFieldFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onAddComment() async {
    setState(() {
      _commentButtonLoading = true;
    });
    final content = _commentController.text;
    final mentions = _generateMentionsFromText(content);
    if (content.isEmpty) return;
    try {
      final comment = await _commentService.addCommentToTrace(
        traceId: widget.trace.id,
        addCommentDto: AddCommentDto(content, mentions),
      );
      if (!mounted) return;
      setState(() {
        _comments.add(comment);
        _commentController.clear();
      });
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e, st) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Nie udało się dodać komentarza')));
      }
      debugPrint('Failed to add comment: $e\n$st');
    } finally {
      if (mounted) {
        setState(() {
          _commentButtonLoading = false;
        });
      }
    }
  }

  void _onTapReply(Comment comment) {
    _commentController.text = '@${comment.author.username} ${_commentController.text}';
    _textFieldFocusNode.requestFocus();
  }

  Future<void> _onDeleteComment(Comment comment) async {
    await _commentService.deleteComment(comment.commentId);
    if (!mounted) return;
    setState(() {
      _comments.remove(comment);
    });
  }

  Future<void> _onTapDeleteTrace() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuwanie śladu', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Czy na pewno chcesz usunąć ten ślad?', style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Usuń'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    if (shouldDelete ?? false) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SpotSpeakDialog(
      title: 'Ślad',
      scrollController: _scrollController,
      action: _authService.user.value.id == widget.trace.author.id
          ? IconButton(
              icon: Icon(Icons.delete, color: CustomColors.red1),
              onPressed: _onTapDeleteTrace,
            )
          : null,
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
                  imageUrl: widget.trace.author.profilePictureUrl!.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Gap(8),
            ],
            Expanded(
              child: Text(
                widget.trace.author.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const Gap(8),
        Align(
          alignment: Alignment.centerLeft,
          child: StreamBuilder<void>(
            stream: Stream<void>.periodic(const Duration(seconds: 1)),
            builder: (context, snapshot) => widget.trace.timeLeft.isNegative
                ? RichText(
                    text: TextSpan(
                      text: 'Dodano: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: DateFormat('dd.MM.yyyy H:m').format(widget.trace.createdAt),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : RichText(
                    text: TextSpan(
                      text: 'Pozostało: ',
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text:
                              '${widget.trace.timeLeft.inHours}:${widget.trace.timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0')}:${widget.trace.timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        const Gap(8),
        Text(
          widget.trace.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        if (widget.trace.resourceAccessUrl != null) ...[
          const Gap(8),
          TraceMedia(mediaUrl: widget.trace.resourceAccessUrl!.toString(), type: widget.trace.type),
        ],
        const Gap(8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text('Komentarze', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        const Gap(8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final comment = _comments[index];
            return _Comment(
              comment: comment,
              onTapReply: () => _onTapReply(comment),
              onDeleteComment: () => _onDeleteComment(comment),
            );
          },
          separatorBuilder: (context, index) => const Gap(8),
          itemCount: _comments.length,
        ),
        const Gap(8),
        TextFormField(
          controller: _commentController,
          style: Theme.of(context).textTheme.bodySmall,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) => _onAddComment(),
          focusNode: _textFieldFocusNode,
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

class _Comment extends StatefulWidget {
  _Comment({
    required this.comment,
    required this.onTapReply,
    required this.onDeleteComment,
  }) : super(key: ValueKey(comment.commentId));

  final Comment comment;
  final VoidCallback onTapReply;
  final VoidCallback onDeleteComment;

  @override
  State<_Comment> createState() => _CommentState();
}

class _CommentState extends State<_Comment> {
  RichText _highlightMentions(BuildContext context) {
    final text = widget.comment.content;
    final mentions = widget.comment.mentions;
    final spans = <TextSpan>[];
    var lastEnd = 0;
    for (final mention in mentions) {
      final mentionText = '@${mention.username}';
      final start = text.indexOf(mentionText, lastEnd);
      final end = start + mentionText.length;
      final GestureRecognizer recognizer;
      if (_gestureRecognizers.keys.contains(mentionText)) {
        recognizer = _gestureRecognizers[mentionText]!;
      } else {
        recognizer = TapGestureRecognizer()
          ..onTap = () {
            if (_userService.user.value.id == mention.mentionedUserId) return;
            context.router.push(UserProfileRoute(userId: mention.mentionedUserId));
          };
        _gestureRecognizers[mentionText] = recognizer;
      }
      spans
        ..add(TextSpan(text: text.substring(lastEnd, start)))
        ..add(
          TextSpan(
            text: mentionText,
            style: TextStyle(fontWeight: FontWeight.bold),
            recognizer: recognizer,
          ),
        );
      lastEnd = end;
    }
    spans.add(TextSpan(text: text.substring(lastEnd)));
    return RichText(
      text: TextSpan(
        children: spans,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
      ),
    );
  }

  final _gestureRecognizers = <String, GestureRecognizer>{};
  final _userService = getIt<UserService>();

  Future<void> _onTapDelete() async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Usuwanie komentarza', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Czy na pewno chcesz usunąć ten komentarz?', style: TextStyle(fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Anuluj'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Usuń'),
          ),
        ],
      ),
    );
    if (shouldDelete ?? false) {
      widget.onDeleteComment();
    }
  }

  @override
  void dispose() {
    for (final recognizer in _gestureRecognizers.values) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.comment.author.profilePictureUrl != null) ...[
            ClipOval(
              child: CachedNetworkImage(
                width: 32,
                height: 32,
                imageUrl: widget.comment.author.profilePictureUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
            const Gap(8),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.comment.author.username,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                    ),
                    Text(
                      TimeOfDay.fromDateTime(widget.comment.createdAt).format(context),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                            fontSize: 14,
                          ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: _highlightMentions(context)),
                    if (_userService.user.value.username == widget.comment.author.username)
                      IconButton(
                        iconSize: 20,
                        visualDensity: VisualDensity.compact,
                        onPressed: _onTapDelete,
                        icon: Icon(Icons.delete),
                      ),
                    IconButton(
                      iconSize: 20,
                      visualDensity: VisualDensity.compact,
                      onPressed: widget.onTapReply,
                      icon: Icon(Icons.reply),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
