import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/models/friendship.dart';
import 'package:spotspeak_mobile/models/friendship_request.dart';
import 'package:spotspeak_mobile/models/other_user_view.dart';
import 'package:spotspeak_mobile/models/ranking_user.dart';
import 'package:spotspeak_mobile/models/search_user.dart';

abstract interface class FriendService {
  Future<List<Friendship>> getFriends();
  Future<List<SearchUser>> searchUsers({required String username});
  Future<OtherUserView> getUser({required String userId});
  Future<FriendshipRequest> rejectRequest({required int requestId});
  Future<FriendshipRequest> acceptRequest({required int requestId});
  Future<FriendshipRequest> sendRequest({required String receiverId});
  Future<List<FriendRequestUserInfo>> getSentRequests();
  Future<List<FriendRequestUserInfo>> getReceivedRequests();
  Future<void> cancelRequest({required int requestId});
  Future<List<RankingUser>> getMutualFriends({required String userId});
  Future<void> unfriend({required String friendId});
}
