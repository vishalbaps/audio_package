// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AudioState {
  AudioLoadingStatus get loadingStatus => throw _privateConstructorUsedError;
  List<AudioContent>? get album => throw _privateConstructorUsedError;
  AudioContent? get audioContent => throw _privateConstructorUsedError;
  Failure? get failure => throw _privateConstructorUsedError;
  bool get isAutoPlay => throw _privateConstructorUsedError;
  bool get isNextAvailable => throw _privateConstructorUsedError;
  bool get isPreviousAvailable => throw _privateConstructorUsedError;
  bool get isShuffleEnabled => throw _privateConstructorUsedError;
  LoopMode get loopMode => throw _privateConstructorUsedError;
  double get audioSpeed => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)
        playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)?
        playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)?
        playing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Playing value) playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Playing value)? playing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioStateCopyWith<AudioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
          AudioState value, $Res Function(AudioState) then) =
      _$AudioStateCopyWithImpl<$Res, AudioState>;
  @useResult
  $Res call(
      {AudioLoadingStatus loadingStatus,
      List<AudioContent>? album,
      AudioContent? audioContent,
      Failure? failure,
      bool isAutoPlay,
      bool isNextAvailable,
      bool isPreviousAvailable,
      bool isShuffleEnabled,
      LoopMode loopMode,
      double audioSpeed});
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingStatus = null,
    Object? album = freezed,
    Object? audioContent = freezed,
    Object? failure = freezed,
    Object? isAutoPlay = null,
    Object? isNextAvailable = null,
    Object? isPreviousAvailable = null,
    Object? isShuffleEnabled = null,
    Object? loopMode = null,
    Object? audioSpeed = null,
  }) {
    return _then(_value.copyWith(
      loadingStatus: null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
              as AudioLoadingStatus,
      album: freezed == album
          ? _value.album
          : album // ignore: cast_nullable_to_non_nullable
              as List<AudioContent>?,
      audioContent: freezed == audioContent
          ? _value.audioContent
          : audioContent // ignore: cast_nullable_to_non_nullable
              as AudioContent?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isAutoPlay: null == isAutoPlay
          ? _value.isAutoPlay
          : isAutoPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      isNextAvailable: null == isNextAvailable
          ? _value.isNextAvailable
          : isNextAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreviousAvailable: null == isPreviousAvailable
          ? _value.isPreviousAvailable
          : isPreviousAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffleEnabled: null == isShuffleEnabled
          ? _value.isShuffleEnabled
          : isShuffleEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      loopMode: null == loopMode
          ? _value.loopMode
          : loopMode // ignore: cast_nullable_to_non_nullable
              as LoopMode,
      audioSpeed: null == audioSpeed
          ? _value.audioSpeed
          : audioSpeed // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayingImplCopyWith<$Res>
    implements $AudioStateCopyWith<$Res> {
  factory _$$PlayingImplCopyWith(
          _$PlayingImpl value, $Res Function(_$PlayingImpl) then) =
      __$$PlayingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AudioLoadingStatus loadingStatus,
      List<AudioContent>? album,
      AudioContent? audioContent,
      Failure? failure,
      bool isAutoPlay,
      bool isNextAvailable,
      bool isPreviousAvailable,
      bool isShuffleEnabled,
      LoopMode loopMode,
      double audioSpeed});
}

/// @nodoc
class __$$PlayingImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$PlayingImpl>
    implements _$$PlayingImplCopyWith<$Res> {
  __$$PlayingImplCopyWithImpl(
      _$PlayingImpl _value, $Res Function(_$PlayingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingStatus = null,
    Object? album = freezed,
    Object? audioContent = freezed,
    Object? failure = freezed,
    Object? isAutoPlay = null,
    Object? isNextAvailable = null,
    Object? isPreviousAvailable = null,
    Object? isShuffleEnabled = null,
    Object? loopMode = null,
    Object? audioSpeed = null,
  }) {
    return _then(_$PlayingImpl(
      null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
              as AudioLoadingStatus,
      album: freezed == album
          ? _value._album
          : album // ignore: cast_nullable_to_non_nullable
              as List<AudioContent>?,
      audioContent: freezed == audioContent
          ? _value.audioContent
          : audioContent // ignore: cast_nullable_to_non_nullable
              as AudioContent?,
      failure: freezed == failure
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as Failure?,
      isAutoPlay: null == isAutoPlay
          ? _value.isAutoPlay
          : isAutoPlay // ignore: cast_nullable_to_non_nullable
              as bool,
      isNextAvailable: null == isNextAvailable
          ? _value.isNextAvailable
          : isNextAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isPreviousAvailable: null == isPreviousAvailable
          ? _value.isPreviousAvailable
          : isPreviousAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isShuffleEnabled: null == isShuffleEnabled
          ? _value.isShuffleEnabled
          : isShuffleEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      loopMode: null == loopMode
          ? _value.loopMode
          : loopMode // ignore: cast_nullable_to_non_nullable
              as LoopMode,
      audioSpeed: null == audioSpeed
          ? _value.audioSpeed
          : audioSpeed // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _$PlayingImpl implements _Playing {
  const _$PlayingImpl(this.loadingStatus,
      {final List<AudioContent>? album,
      this.audioContent,
      this.failure,
      this.isAutoPlay = false,
      this.isNextAvailable = true,
      this.isPreviousAvailable = false,
      this.isShuffleEnabled = false,
      this.loopMode = LoopMode.off,
      this.audioSpeed = 1.0})
      : _album = album;

  @override
  final AudioLoadingStatus loadingStatus;
  final List<AudioContent>? _album;
  @override
  List<AudioContent>? get album {
    final value = _album;
    if (value == null) return null;
    if (_album is EqualUnmodifiableListView) return _album;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AudioContent? audioContent;
  @override
  final Failure? failure;
  @override
  @JsonKey()
  final bool isAutoPlay;
  @override
  @JsonKey()
  final bool isNextAvailable;
  @override
  @JsonKey()
  final bool isPreviousAvailable;
  @override
  @JsonKey()
  final bool isShuffleEnabled;
  @override
  @JsonKey()
  final LoopMode loopMode;
  @override
  @JsonKey()
  final double audioSpeed;

  @override
  String toString() {
    return 'AudioState.playing(loadingStatus: $loadingStatus, album: $album, audioContent: $audioContent, failure: $failure, isAutoPlay: $isAutoPlay, isNextAvailable: $isNextAvailable, isPreviousAvailable: $isPreviousAvailable, isShuffleEnabled: $isShuffleEnabled, loopMode: $loopMode, audioSpeed: $audioSpeed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayingImpl &&
            (identical(other.loadingStatus, loadingStatus) ||
                other.loadingStatus == loadingStatus) &&
            const DeepCollectionEquality().equals(other._album, _album) &&
            (identical(other.audioContent, audioContent) ||
                other.audioContent == audioContent) &&
            (identical(other.failure, failure) || other.failure == failure) &&
            (identical(other.isAutoPlay, isAutoPlay) ||
                other.isAutoPlay == isAutoPlay) &&
            (identical(other.isNextAvailable, isNextAvailable) ||
                other.isNextAvailable == isNextAvailable) &&
            (identical(other.isPreviousAvailable, isPreviousAvailable) ||
                other.isPreviousAvailable == isPreviousAvailable) &&
            (identical(other.isShuffleEnabled, isShuffleEnabled) ||
                other.isShuffleEnabled == isShuffleEnabled) &&
            (identical(other.loopMode, loopMode) ||
                other.loopMode == loopMode) &&
            (identical(other.audioSpeed, audioSpeed) ||
                other.audioSpeed == audioSpeed));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      loadingStatus,
      const DeepCollectionEquality().hash(_album),
      audioContent,
      failure,
      isAutoPlay,
      isNextAvailable,
      isPreviousAvailable,
      isShuffleEnabled,
      loopMode,
      audioSpeed);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      __$$PlayingImplCopyWithImpl<_$PlayingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)
        playing,
  }) {
    return playing(
        loadingStatus,
        album,
        audioContent,
        failure,
        isAutoPlay,
        isNextAvailable,
        isPreviousAvailable,
        isShuffleEnabled,
        loopMode,
        audioSpeed);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)?
        playing,
  }) {
    return playing?.call(
        loadingStatus,
        album,
        audioContent,
        failure,
        isAutoPlay,
        isNextAvailable,
        isPreviousAvailable,
        isShuffleEnabled,
        loopMode,
        audioSpeed);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            AudioLoadingStatus loadingStatus,
            List<AudioContent>? album,
            AudioContent? audioContent,
            Failure? failure,
            bool isAutoPlay,
            bool isNextAvailable,
            bool isPreviousAvailable,
            bool isShuffleEnabled,
            LoopMode loopMode,
            double audioSpeed)?
        playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(
          loadingStatus,
          album,
          audioContent,
          failure,
          isAutoPlay,
          isNextAvailable,
          isPreviousAvailable,
          isShuffleEnabled,
          loopMode,
          audioSpeed);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Playing value) playing,
  }) {
    return playing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Playing value)? playing,
  }) {
    return playing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Playing value)? playing,
    required TResult orElse(),
  }) {
    if (playing != null) {
      return playing(this);
    }
    return orElse();
  }
}

abstract class _Playing implements AudioState {
  const factory _Playing(final AudioLoadingStatus loadingStatus,
      {final List<AudioContent>? album,
      final AudioContent? audioContent,
      final Failure? failure,
      final bool isAutoPlay,
      final bool isNextAvailable,
      final bool isPreviousAvailable,
      final bool isShuffleEnabled,
      final LoopMode loopMode,
      final double audioSpeed}) = _$PlayingImpl;

  @override
  AudioLoadingStatus get loadingStatus;
  @override
  List<AudioContent>? get album;
  @override
  AudioContent? get audioContent;
  @override
  Failure? get failure;
  @override
  bool get isAutoPlay;
  @override
  bool get isNextAvailable;
  @override
  bool get isPreviousAvailable;
  @override
  bool get isShuffleEnabled;
  @override
  LoopMode get loopMode;
  @override
  double get audioSpeed;
  @override
  @JsonKey(ignore: true)
  _$$PlayingImplCopyWith<_$PlayingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
