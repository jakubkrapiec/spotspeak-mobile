import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/dtos/add_comment_dto.dart';
import 'package:spotspeak_mobile/models/comment.dart';

part 'comment_service.g.dart';

@lazySingleton
@RestApi(baseUrl: '/api/traces/comments')
abstract class CommentService {
  @factoryMethod
  factory CommentService(Dio dio) = _CommentService;

  @POST('/{traceId}')
  Future<Comment> addCommentToTrace({
    @Path() required int traceId,
    @Body() required AddCommentDto addCommentDto,
  });

  @PUT('/{id}')
  Future<Comment> editComment({
    @Path() required int id,
    @Body() required AddCommentDto addCommentDto,
  });

  @GET('/{traceId}')
  Future<List<Comment>> getCommentsForTrace({@Path() required int traceId});

  @DELETE('/{id}')
  Future<void> deleteComment(@Path() int id);
}
