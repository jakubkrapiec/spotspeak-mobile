import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/models/friendship.dart';
import 'package:spotspeak_mobile/models/friendship_request.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/models/search_user.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

part 'friend_service_impl.g.dart';

@prod
@Singleton(as: FriendService)
@RestApi(baseUrl: '/api')
abstract class FriendServiceImpl implements FriendService {
  @factoryMethod
  factory FriendServiceImpl(Dio dio) = _FriendServiceImpl;

  @override
  @GET('/friends')
  Future<List<Friendship>> getFriends();

  @override
  @GET('/users/search')
  Future<List<SearchUser>> searchUsers({@Query('username') required String username});

  @override
  @GET('/users/profile/{userId}')
  Future<OtherUserView> getUser({@Path('userId') required String userId});

  @override
  @PUT('/friend-requests/reject/{requestId}')
  Future<FriendshipRequest> rejectRequest({@Path('requestId') required int requestId});

  @override
  @PUT('/friend-requests/accept/{requestId}')
  Future<FriendshipRequest> acceptRequest({@Path('requestId') required int requestId});

  @override
  @POST('/friend-requests/send/{receiverId}')
  Future<FriendshipRequest> sendRequest({@Path('receiverId') required String receiverId});

  @override
  @GET('/friend-requests/sent')
  Future<List<FriendRequestUserInfo>> getSentRequests();

  @override
  @GET('/friend-requests/received')
  Future<List<FriendRequestUserInfo>> getReceivedRequests();

  @override
  @DELETE('/friend-requests/cancel/{requestId}')
  Future<void> cancelRequest({@Path('requestId') required int requestId});

  @override
  @GET('/friends/mutual/{userId}')
  Future<List<RankingUser>> getMutualFriends({@Path('userId') required String userId});

  @override
  @DELETE('/friends/{friendId}')
  Future<void> unfriend({@Path('friendId') required String friendId});
}
