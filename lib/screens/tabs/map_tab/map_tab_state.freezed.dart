// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_tab_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MapTabState {
  bool get isAddingTrace => throw _privateConstructorUsedError;
  Position? get lastLocation => throw _privateConstructorUsedError;
  List<TraceLocation> get traces => throw _privateConstructorUsedError;
  List<EventLocation> get events => throw _privateConstructorUsedError;

  /// Create a copy of MapTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MapTabStateCopyWith<MapTabState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MapTabStateCopyWith<$Res> {
  factory $MapTabStateCopyWith(
          MapTabState value, $Res Function(MapTabState) then) =
      _$MapTabStateCopyWithImpl<$Res, MapTabState>;
  @useResult
  $Res call(
      {bool isAddingTrace,
      Position? lastLocation,
      List<TraceLocation> traces,
      List<EventLocation> events});
}

/// @nodoc
class _$MapTabStateCopyWithImpl<$Res, $Val extends MapTabState>
    implements $MapTabStateCopyWith<$Res> {
  _$MapTabStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MapTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAddingTrace = null,
    Object? lastLocation = freezed,
    Object? traces = null,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
      isAddingTrace: null == isAddingTrace
          ? _value.isAddingTrace
          : isAddingTrace // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLocation: freezed == lastLocation
          ? _value.lastLocation
          : lastLocation // ignore: cast_nullable_to_non_nullable
              as Position?,
      traces: null == traces
          ? _value.traces
          : traces // ignore: cast_nullable_to_non_nullable
              as List<TraceLocation>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<EventLocation>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MapTabStateImplCopyWith<$Res>
    implements $MapTabStateCopyWith<$Res> {
  factory _$$MapTabStateImplCopyWith(
          _$MapTabStateImpl value, $Res Function(_$MapTabStateImpl) then) =
      __$$MapTabStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isAddingTrace,
      Position? lastLocation,
      List<TraceLocation> traces,
      List<EventLocation> events});
}

/// @nodoc
class __$$MapTabStateImplCopyWithImpl<$Res>
    extends _$MapTabStateCopyWithImpl<$Res, _$MapTabStateImpl>
    implements _$$MapTabStateImplCopyWith<$Res> {
  __$$MapTabStateImplCopyWithImpl(
      _$MapTabStateImpl _value, $Res Function(_$MapTabStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MapTabState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAddingTrace = null,
    Object? lastLocation = freezed,
    Object? traces = null,
    Object? events = null,
  }) {
    return _then(_$MapTabStateImpl(
      isAddingTrace: null == isAddingTrace
          ? _value.isAddingTrace
          : isAddingTrace // ignore: cast_nullable_to_non_nullable
              as bool,
      lastLocation: freezed == lastLocation
          ? _value.lastLocation
          : lastLocation // ignore: cast_nullable_to_non_nullable
              as Position?,
      traces: null == traces
          ? _value._traces
          : traces // ignore: cast_nullable_to_non_nullable
              as List<TraceLocation>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<EventLocation>,
    ));
  }
}

/// @nodoc

class _$MapTabStateImpl implements _MapTabState {
  const _$MapTabStateImpl(
      {required this.isAddingTrace,
      required this.lastLocation,
      required final List<TraceLocation> traces,
      required final List<EventLocation> events})
      : _traces = traces,
        _events = events;

  @override
  final bool isAddingTrace;
  @override
  final Position? lastLocation;
  final List<TraceLocation> _traces;
  @override
  List<TraceLocation> get traces {
    if (_traces is EqualUnmodifiableListView) return _traces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_traces);
  }

  final List<EventLocation> _events;
  @override
  List<EventLocation> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'MapTabState(isAddingTrace: $isAddingTrace, lastLocation: $lastLocation, traces: $traces, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MapTabStateImpl &&
            (identical(other.isAddingTrace, isAddingTrace) ||
                other.isAddingTrace == isAddingTrace) &&
            (identical(other.lastLocation, lastLocation) ||
                other.lastLocation == lastLocation) &&
            const DeepCollectionEquality().equals(other._traces, _traces) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isAddingTrace,
      lastLocation,
      const DeepCollectionEquality().hash(_traces),
      const DeepCollectionEquality().hash(_events));

  /// Create a copy of MapTabState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MapTabStateImplCopyWith<_$MapTabStateImpl> get copyWith =>
      __$$MapTabStateImplCopyWithImpl<_$MapTabStateImpl>(this, _$identity);
}

abstract class _MapTabState implements MapTabState {
  const factory _MapTabState(
      {required final bool isAddingTrace,
      required final Position? lastLocation,
      required final List<TraceLocation> traces,
      required final List<EventLocation> events}) = _$MapTabStateImpl;

  @override
  bool get isAddingTrace;
  @override
  Position? get lastLocation;
  @override
  List<TraceLocation> get traces;
  @override
  List<EventLocation> get events;

  /// Create a copy of MapTabState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MapTabStateImplCopyWith<_$MapTabStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
