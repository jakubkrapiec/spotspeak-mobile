import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/search_user.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

part 'search_friends_bloc.freezed.dart';

@injectable
class SearchFriendsBloc extends Bloc<SearchFriendsEvent, SearchFriendsState> {
  SearchFriendsBloc(this._friendService) : super(SearchFriendsState.initial()) {
    on<ModifyQueryEvent>(_onModifyQueryEvent);
    on<RetryEvent>(_onRetryEvent);
    on<SendFriendRequestEvent>(_onSendFriendRequestEvent);
  }

  final FriendService _friendService;

  String? _currentQuery;

  Future<void> _onModifyQueryEvent(ModifyQueryEvent event, Emitter<SearchFriendsState> emit) async {
    try {
      if (event.query.isEmpty) {
        _currentQuery = null;
        emit(state.copyWith(users: [], status: LoadingStatus.loaded));
        return;
      }

      if (event.query == _currentQuery) return;

      _currentQuery = event.query;

      emit(state.copyWith(status: LoadingStatus.loading));

      await Future<void>.delayed(const Duration(milliseconds: 300));

      if (event.query != _currentQuery || isClosed) return;

      final searchedQuery = _currentQuery ?? '';
      final users = await _friendService.searchUsers(username: searchedQuery);

      if (searchedQuery != _currentQuery || isClosed) return;
      emit(state.copyWith(users: users, status: LoadingStatus.loaded));
    } catch (e, st) {
      debugPrint('$e\n$st');
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }

  Future<void> _onRetryEvent(RetryEvent event, Emitter<SearchFriendsState> emit) async {
    try {
      emit(state.copyWith(status: LoadingStatus.loading));

      final searchedQuery = _currentQuery ?? '';
      final users = await _friendService.searchUsers(username: searchedQuery);

      if (searchedQuery != _currentQuery || isClosed) return;
      emit(state.copyWith(users: users, status: LoadingStatus.loaded));
    } catch (e, st) {
      debugPrint('$e\n$st');
      emit(state.copyWith(status: LoadingStatus.error));
    }
  }

  Future<void> _onSendFriendRequestEvent(SendFriendRequestEvent event, Emitter<SearchFriendsState> emit) async {
    await _friendService.sendRequest(receiverId: event.userId);
  }
}

abstract class SearchFriendsEvent {
  const SearchFriendsEvent();
}

class ModifyQueryEvent extends SearchFriendsEvent {
  const ModifyQueryEvent(this.query);

  final String query;
}

class RetryEvent extends SearchFriendsEvent {
  const RetryEvent();
}

class SendFriendRequestEvent extends SearchFriendsEvent {
  const SendFriendRequestEvent(this.userId);

  final String userId;
}

@freezed
class SearchFriendsState with _$SearchFriendsState {
  const factory SearchFriendsState({
    required List<SearchUser> users,
    required LoadingStatus status,
  }) = _SearchFriendsState;

  factory SearchFriendsState.initial() => SearchFriendsState(users: [], status: LoadingStatus.loaded);
}
