import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/services/comment_service.dart';

@test
@LazySingleton(as: CommentService)
class CommentServiceImpl implements CommentService {
  @override
  Future<Comment> addCommentToTrace({required int traceId, required AddCommentDto addCommentDto}) =>
      throw UnimplementedError();

  @override
  Future<Comment> editComment({required int id, required AddCommentDto addCommentDto}) => throw UnimplementedError();

  @override
  Future<List<Comment>> getCommentsForTrace({required int traceId}) => throw UnimplementedError();

  @override
  Future<void> deleteComment(int id) => throw UnimplementedError();
}
