import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/models/friendship.dart';
import 'package:spotspeak_mobile/models/friendship_request.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/models/search_user.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

@test
@Singleton(as: FriendService)
class FriendServiceMock implements FriendService {
  @override
  Future<List<Friendship>> getFriends() async => throw UnimplementedError();

  @override
  Future<List<SearchUser>> searchUsers({required String username}) async => throw UnimplementedError();

  @override
  Future<OtherUserView> getUser({required String userId}) async => throw UnimplementedError();

  @override
  Future<FriendshipRequest> rejectRequest({required int requestId}) async => throw UnimplementedError();

  @override
  Future<FriendshipRequest> acceptRequest({required int requestId}) async => throw UnimplementedError();

  @override
  Future<FriendshipRequest> sendRequest({required String receiverId}) async => throw UnimplementedError();

  @override
  Future<List<FriendRequestUserInfo>> getSentRequests() async => throw UnimplementedError();

  @override
  Future<List<FriendRequestUserInfo>> getReceivedRequests() async => throw UnimplementedError();

  @override
  Future<void> cancelRequest({required int requestId}) async => throw UnimplementedError();

  @override
  Future<List<RankingUser>> getMutualFriends({required String userId}) async => throw UnimplementedError();

  @override
  Future<void> unfriend({required String friendId}) async => throw UnimplementedError();
}
