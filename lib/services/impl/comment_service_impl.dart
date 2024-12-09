import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';
import 'package:spotspeak_mobile/services/comment_service.dart';

part 'comment_service_impl.g.dart';

@prod
@LazySingleton(as: CommentService)
@RestApi(baseUrl: '/api/traces/comments')
abstract class CommentServiceImpl implements CommentService {
  @factoryMethod
  factory CommentServiceImpl(Dio dio) = _CommentServiceImpl;

  @override
  @POST('/{traceId}')
  Future<Comment> addCommentToTrace({
    @Path() required int traceId,
    @Body() required AddCommentDto addCommentDto,
  });

  @override
  @PUT('/{id}')
  Future<Comment> editComment({
    @Path() required int id,
    @Body() required AddCommentDto addCommentDto,
  });

  @override
  @GET('/{traceId}')
  Future<List<Comment>> getCommentsForTrace({@Path() required int traceId});

  @override
  @DELETE('/{id}')
  Future<void> deleteComment(@Path() int id);
}
