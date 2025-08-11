// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_player_config_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by Freezed and you are not supposed to need it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioPlayerConfigState {
  AudioManagerStatus get loadingStatus => throw _privateConstructorUsedError;
  AudioManager? get audioManager => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AudioPlayerConfigStateCopyWith<AudioPlayerConfigState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioPlayerConfigStateCopyWith<$Res> {
  factory $AudioPlayerConfigStateCopyWith(AudioPlayerConfigState value,
      $Res Function(AudioPlayerConfigState) then) =
  _$AudioPlayerConfigStateCopyWithImpl<$Res, AudioPlayerConfigState>;
  @useResult
  $Res call({AudioManagerStatus loadingStatus, AudioManager? audioManager});
}

/// @nodoc
class _$AudioPlayerConfigStateCopyWithImpl<$Res,
$Val extends AudioPlayerConfigState>
    implements $AudioPlayerConfigStateCopyWith<$Res> {
  _$AudioPlayerConfigStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingStatus = null,
    Object? audioManager = freezed,
  }) {
    return _then(_value.copyWith(
      loadingStatus: null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
      as AudioManagerStatus,
      audioManager: freezed == audioManager
          ? _value.audioManager
          : audioManager // ignore: cast_nullable_to_non_nullable
      as AudioManager?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AudioPlayerConfigStateImplCopyWith<$Res>
    implements $AudioPlayerConfigStateCopyWith<$Res> {
  factory _$$AudioPlayerConfigStateImplCopyWith(
      _$AudioPlayerConfigStateImpl value,
      $Res Function(_$AudioPlayerConfigStateImpl) then) =
  __$$AudioPlayerConfigStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AudioManagerStatus loadingStatus, AudioManager? audioManager});
}

/// @nodoc
class __$$AudioPlayerConfigStateImplCopyWithImpl<$Res>
    extends _$AudioPlayerConfigStateCopyWithImpl<$Res,
        _$AudioPlayerConfigStateImpl>
    implements _$$AudioPlayerConfigStateImplCopyWith<$Res> {
  __$$AudioPlayerConfigStateImplCopyWithImpl(
      _$AudioPlayerConfigStateImpl _value,
      $Res Function(_$AudioPlayerConfigStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loadingStatus = null,
    Object? audioManager = freezed,
  }) {
    return _then(_$AudioPlayerConfigStateImpl(
      null == loadingStatus
          ? _value.loadingStatus
          : loadingStatus // ignore: cast_nullable_to_non_nullable
      as AudioManagerStatus,
      freezed == audioManager
          ? _value.audioManager
          : audioManager // ignore: cast_nullable_to_non_nullable
      as AudioManager?,
    ));
  }
}

/// @nodoc

class _$AudioPlayerConfigStateImpl implements _AudioPlayerConfigState {
  const _$AudioPlayerConfigStateImpl(this.loadingStatus, this.audioManager);

  @override
  final AudioManagerStatus loadingStatus;
  @override
  final AudioManager? audioManager;

  @override
  String toString() {
    return 'AudioPlayerConfigState(loadingStatus: $loadingStatus, audioManager: $audioManager)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioPlayerConfigStateImpl &&
            (identical(other.loadingStatus, loadingStatus) ||
                other.loadingStatus == loadingStatus) &&
            (identical(other.audioManager, audioManager) ||
                other.audioManager == audioManager));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loadingStatus, audioManager);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioPlayerConfigStateImplCopyWith<_$AudioPlayerConfigStateImpl>
  get copyWith => __$$AudioPlayerConfigStateImplCopyWithImpl<
      _$AudioPlayerConfigStateImpl>(this, _$identity);
}

abstract class _AudioPlayerConfigState implements AudioPlayerConfigState {
  const factory _AudioPlayerConfigState(
      final AudioManagerStatus loadingStatus,
      final AudioManager? audioManager) =
  _$AudioPlayerConfigStateImpl;

  @override
  AudioManagerStatus get loadingStatus;
  @override
  AudioManager? get audioManager;
  @override
  @JsonKey(ignore: true)
  _$$AudioPlayerConfigStateImplCopyWith<_$AudioPlayerConfigStateImpl>
  get copyWith => throw _privateConstructorUsedError;
}
