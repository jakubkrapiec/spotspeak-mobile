import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/models/friendship_request.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/search_user.dart';

part 'friend_service.g.dart';

@singleton
@RestApi(baseUrl: '/api')
abstract class FriendService {
  @factoryMethod
  factory FriendService(Dio dio) = _FriendService;

  @GET('/users/search')
  Future<List<SearchUser>> searchUsers({@Query('username') required String username});

  @GET('/users/profile/{userId}')
  Future<OtherUserView> getUser({@Query('userId') required String userId});

  @PUT('/friend-requests/reject/{requestId}')
  Future<FriendshipRequest> rejectRequest({@Path('requestId') required int requestId});

  @PUT('/friend-requests/accept/{requestId}')
  Future<FriendshipRequest> acceptRequest({@Path('requestId') required int requestId});

  @POST('/friend-requests/send/{receiverId}')
  Future<FriendshipRequest> sendRequest({@Path('receiverId') required String receiverId});

  @GET('/friend-requests/sent')
  Future<List<FriendRequestUserInfo>> getSentRequests();

  @GET('/friend-requests/received')
  Future<List<FriendRequestUserInfo>> getReceivedRequests();

  @DELETE('/friend-requests/cancel/{requestId}')
  Future<void> cancelRequest({@Path('requestId') required int requestId});
}
