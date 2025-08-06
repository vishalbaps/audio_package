// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider_seek_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SliderSeekState {
  Duration get currentDuration => throw _privateConstructorUsedError;
  Duration get totalDuration => throw _privateConstructorUsedError;
  bool get isUserSeek => throw _privateConstructorUsedError;
  double get playPosition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SliderSeekStateCopyWith<SliderSeekState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SliderSeekStateCopyWith<$Res> {
  factory $SliderSeekStateCopyWith(
          SliderSeekState value, $Res Function(SliderSeekState) then) =
      _$SliderSeekStateCopyWithImpl<$Res, SliderSeekState>;
  @useResult
  $Res call(
      {Duration currentDuration,
      Duration totalDuration,
      bool isUserSeek,
      double playPosition});
}

/// @nodoc
class _$SliderSeekStateCopyWithImpl<$Res, $Val extends SliderSeekState>
    implements $SliderSeekStateCopyWith<$Res> {
  _$SliderSeekStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDuration = null,
    Object? totalDuration = null,
    Object? isUserSeek = null,
    Object? playPosition = null,
  }) {
    return _then(_value.copyWith(
      currentDuration: null == currentDuration
          ? _value.currentDuration
          : currentDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      totalDuration: null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      isUserSeek: null == isUserSeek
          ? _value.isUserSeek
          : isUserSeek // ignore: cast_nullable_to_non_nullable
              as bool,
      playPosition: null == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SliderSeekStateImplCopyWith<$Res>
    implements $SliderSeekStateCopyWith<$Res> {
  factory _$$SliderSeekStateImplCopyWith(_$SliderSeekStateImpl value,
          $Res Function(_$SliderSeekStateImpl) then) =
      __$$SliderSeekStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Duration currentDuration,
      Duration totalDuration,
      bool isUserSeek,
      double playPosition});
}

/// @nodoc
class __$$SliderSeekStateImplCopyWithImpl<$Res>
    extends _$SliderSeekStateCopyWithImpl<$Res, _$SliderSeekStateImpl>
    implements _$$SliderSeekStateImplCopyWith<$Res> {
  __$$SliderSeekStateImplCopyWithImpl(
      _$SliderSeekStateImpl _value, $Res Function(_$SliderSeekStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentDuration = null,
    Object? totalDuration = null,
    Object? isUserSeek = null,
    Object? playPosition = null,
  }) {
    return _then(_$SliderSeekStateImpl(
      null == currentDuration
          ? _value.currentDuration
          : currentDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      null == totalDuration
          ? _value.totalDuration
          : totalDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      null == isUserSeek
          ? _value.isUserSeek
          : isUserSeek // ignore: cast_nullable_to_non_nullable
              as bool,
      null == playPosition
          ? _value.playPosition
          : playPosition // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$SliderSeekStateImpl implements _SliderSeekState {
  const _$SliderSeekStateImpl(this.currentDuration, this.totalDuration,
      this.isUserSeek, this.playPosition);

  @override
  final Duration currentDuration;
  @override
  final Duration totalDuration;
  @override
  final bool isUserSeek;
  @override
  final double playPosition;

  @override
  String toString() {
    return 'SliderSeekState(currentDuration: $currentDuration, totalDuration: $totalDuration, isUserSeek: $isUserSeek, playPosition: $playPosition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SliderSeekStateImpl &&
            (identical(other.currentDuration, currentDuration) ||
                other.currentDuration == currentDuration) &&
            (identical(other.totalDuration, totalDuration) ||
                other.totalDuration == totalDuration) &&
            (identical(other.isUserSeek, isUserSeek) ||
                other.isUserSeek == isUserSeek) &&
            (identical(other.playPosition, playPosition) ||
                other.playPosition == playPosition));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, currentDuration, totalDuration, isUserSeek, playPosition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SliderSeekStateImplCopyWith<_$SliderSeekStateImpl> get copyWith =>
      __$$SliderSeekStateImplCopyWithImpl<_$SliderSeekStateImpl>(
          this, _$identity);
}

abstract class _SliderSeekState implements SliderSeekState {
  const factory _SliderSeekState(
      final Duration currentDuration,
      final Duration totalDuration,
      final bool isUserSeek,
      final double playPosition) = _$SliderSeekStateImpl;

  @override
  Duration get currentDuration;
  @override
  Duration get totalDuration;
  @override
  bool get isUserSeek;
  @override
  double get playPosition;
  @override
  @JsonKey(ignore: true)
  _$$SliderSeekStateImplCopyWith<_$SliderSeekStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
