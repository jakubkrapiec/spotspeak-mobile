// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_friends_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchFriendsState {
  List<SearchUser> get users => throw _privateConstructorUsedError;
  LoadingStatus get status => throw _privateConstructorUsedError;

  /// Create a copy of SearchFriendsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SearchFriendsStateCopyWith<SearchFriendsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFriendsStateCopyWith<$Res> {
  factory $SearchFriendsStateCopyWith(
          SearchFriendsState value, $Res Function(SearchFriendsState) then) =
      _$SearchFriendsStateCopyWithImpl<$Res, SearchFriendsState>;
  @useResult
  $Res call({List<SearchUser> users, LoadingStatus status});
}

/// @nodoc
class _$SearchFriendsStateCopyWithImpl<$Res, $Val extends SearchFriendsState>
    implements $SearchFriendsStateCopyWith<$Res> {
  _$SearchFriendsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SearchFriendsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<SearchUser>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchFriendsStateImplCopyWith<$Res>
    implements $SearchFriendsStateCopyWith<$Res> {
  factory _$$SearchFriendsStateImplCopyWith(_$SearchFriendsStateImpl value,
          $Res Function(_$SearchFriendsStateImpl) then) =
      __$$SearchFriendsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<SearchUser> users, LoadingStatus status});
}

/// @nodoc
class __$$SearchFriendsStateImplCopyWithImpl<$Res>
    extends _$SearchFriendsStateCopyWithImpl<$Res, _$SearchFriendsStateImpl>
    implements _$$SearchFriendsStateImplCopyWith<$Res> {
  __$$SearchFriendsStateImplCopyWithImpl(_$SearchFriendsStateImpl _value,
      $Res Function(_$SearchFriendsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SearchFriendsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? status = null,
  }) {
    return _then(_$SearchFriendsStateImpl(
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<SearchUser>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoadingStatus,
    ));
  }
}

/// @nodoc

class _$SearchFriendsStateImpl
    with DiagnosticableTreeMixin
    implements _SearchFriendsState {
  const _$SearchFriendsStateImpl(
      {required final List<SearchUser> users, required this.status})
      : _users = users;

  final List<SearchUser> _users;
  @override
  List<SearchUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  final LoadingStatus status;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SearchFriendsState(users: $users, status: $status)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SearchFriendsState'))
      ..add(DiagnosticsProperty('users', users))
      ..add(DiagnosticsProperty('status', status));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchFriendsStateImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_users), status);

  /// Create a copy of SearchFriendsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchFriendsStateImplCopyWith<_$SearchFriendsStateImpl> get copyWith =>
      __$$SearchFriendsStateImplCopyWithImpl<_$SearchFriendsStateImpl>(
          this, _$identity);
}

abstract class _SearchFriendsState implements SearchFriendsState {
  const factory _SearchFriendsState(
      {required final List<SearchUser> users,
      required final LoadingStatus status}) = _$SearchFriendsStateImpl;

  @override
  List<SearchUser> get users;
  @override
  LoadingStatus get status;

  /// Create a copy of SearchFriendsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SearchFriendsStateImplCopyWith<_$SearchFriendsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
