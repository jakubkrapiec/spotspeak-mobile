// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_requests_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FriendRequestsState {
  List<FriendRequestUserInfo> get requests =>
      throw _privateConstructorUsedError;
  LoadingStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestsStateCopyWith<FriendRequestsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestsStateCopyWith<$Res> {
  factory $FriendRequestsStateCopyWith(
          FriendRequestsState value, $Res Function(FriendRequestsState) then) =
      _$FriendRequestsStateCopyWithImpl<$Res, FriendRequestsState>;
  @useResult
  $Res call({List<FriendRequestUserInfo> requests, LoadingStatus status});
}

/// @nodoc
class _$FriendRequestsStateCopyWithImpl<$Res, $Val extends FriendRequestsState>
    implements $FriendRequestsStateCopyWith<$Res> {
  _$FriendRequestsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      requests: null == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequestUserInfo>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FriendRequestsStateImplCopyWith<$Res>
    implements $FriendRequestsStateCopyWith<$Res> {
  factory _$$FriendRequestsStateImplCopyWith(_$FriendRequestsStateImpl value,
          $Res Function(_$FriendRequestsStateImpl) then) =
      __$$FriendRequestsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FriendRequestUserInfo> requests, LoadingStatus status});
}

/// @nodoc
class __$$FriendRequestsStateImplCopyWithImpl<$Res>
    extends _$FriendRequestsStateCopyWithImpl<$Res, _$FriendRequestsStateImpl>
    implements _$$FriendRequestsStateImplCopyWith<$Res> {
  __$$FriendRequestsStateImplCopyWithImpl(_$FriendRequestsStateImpl _value,
      $Res Function(_$FriendRequestsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FriendRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requests = null,
    Object? status = null,
  }) {
    return _then(_$FriendRequestsStateImpl(
      requests: null == requests
          ? _value._requests
          : requests // ignore: cast_nullable_to_non_nullable
              as List<FriendRequestUserInfo>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ));
  }
}

/// @nodoc

class _$FriendRequestsStateImpl implements _FriendRequestsState {
  const _$FriendRequestsStateImpl(
      {required final List<FriendRequestUserInfo> requests,
      required this.status})
      : _requests = requests;

  final List<FriendRequestUserInfo> _requests;
  @override
  List<FriendRequestUserInfo> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  final LoadingStatus status;

  @override
  String toString() {
    return 'FriendRequestsState(requests: $requests, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestsStateImpl &&
            const DeepCollectionEquality().equals(other._requests, _requests) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_requests), status);

  /// Create a copy of FriendRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestsStateImplCopyWith<_$FriendRequestsStateImpl> get copyWith =>
      __$$FriendRequestsStateImplCopyWithImpl<_$FriendRequestsStateImpl>(
          this, _$identity);
}

abstract class _FriendRequestsState implements FriendRequestsState {
  const factory _FriendRequestsState(
      {required final List<FriendRequestUserInfo> requests,
      required final LoadingStatus status}) = _$FriendRequestsStateImpl;

  @override
  List<FriendRequestUserInfo> get requests;
  @override
  LoadingStatus get status;

  /// Create a copy of FriendRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestsStateImplCopyWith<_$FriendRequestsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
