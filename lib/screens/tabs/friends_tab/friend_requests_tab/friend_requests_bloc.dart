import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:spotspeak_mobile/misc/loading_status.dart';
import 'package:spotspeak_mobile/models/friend_request_user_info.dart';
import 'package:spotspeak_mobile/services/friend_service.dart';

part 'friend_requests_bloc.freezed.dart';

@injectable
class FriendRequestsBloc extends Bloc<FriendRequestsEvent, FriendRequestsState> {
  FriendRequestsBloc(this._friendService) : super(FriendRequestsState.initial()) {
    on<FetchFriendRequestsEvent>(_onFetchFriendRequestsEvent);
    on<AcceptFriendshipEvent>(_onAcceptFriendshipEvent);
    on<DenyFriendshipEvent>(_onDenyFriendshipEvent);

    add(const FetchFriendRequestsEvent());
  }

  final FriendService _friendService;

  Future<void> _onFetchFriendRequestsEvent(FetchFriendRequestsEvent event, Emitter<FriendRequestsState> emit) async {
    emit(state.copyWith(status: LoadingStatus.loading));

    final requests = await _friendService.getReceivedRequests();

    emit(state.copyWith(requests: requests, status: LoadingStatus.loaded));
  }

  Future<void> _onAcceptFriendshipEvent(AcceptFriendshipEvent event, Emitter<FriendRequestsState> emit) async {
    await _friendService.acceptRequest(requestId: event.requestId);

    final requests = await _friendService.getReceivedRequests();

    emit(state.copyWith(requests: requests, status: LoadingStatus.loaded));
  }

  Future<void> _onDenyFriendshipEvent(DenyFriendshipEvent event, Emitter<FriendRequestsState> emit) async {
    await _friendService.rejectRequest(requestId: event.requestId);

    final requests = await _friendService.getReceivedRequests();

    emit(state.copyWith(requests: requests, status: LoadingStatus.loaded));
  }
}

abstract class FriendRequestsEvent {
  const FriendRequestsEvent();
}

class FetchFriendRequestsEvent extends FriendRequestsEvent {
  const FetchFriendRequestsEvent();
}

class AcceptFriendshipEvent extends FriendRequestsEvent {
  const AcceptFriendshipEvent(this.requestId);

  final int requestId;
}

class DenyFriendshipEvent extends FriendRequestsEvent {
  const DenyFriendshipEvent(this.requestId);

  final int requestId;
}

@freezed
class FriendRequestsState with _$FriendRequestsState {
  const factory FriendRequestsState({
    required List<FriendRequestUserInfo> requests,
    required LoadingStatus status,
  }) = _FriendRequestsState;

  factory FriendRequestsState.initial() => FriendRequestsState(requests: [], status: LoadingStatus.loading);
}
