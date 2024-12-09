import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';

abstract interface class CommentService {
  Future<Comment> addCommentToTrace({required int traceId, required AddCommentDto addCommentDto});
  Future<Comment> editComment({required int id, required AddCommentDto addCommentDto});
  Future<List<Comment>> getCommentsForTrace({required int traceId});
  Future<void> deleteComment(int id);
}
