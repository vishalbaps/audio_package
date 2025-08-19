// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioState {

 AudioLoadingStatus get loadingStatus; List<AudioContent>? get album; AudioContent? get audioContent; Failure? get failure; bool get isAutoPlay; bool get isNextAvailable; bool get isPreviousAvailable; bool get isShuffleEnabled; LoopMode get loopMode; double get audioSpeed;
/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStateCopyWith<AudioState> get copyWith => _$AudioStateCopyWithImpl<AudioState>(this as AudioState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioState&&(identical(other.loadingStatus, loadingStatus) || other.loadingStatus == loadingStatus)&&const DeepCollectionEquality().equals(other.album, album)&&(identical(other.audioContent, audioContent) || other.audioContent == audioContent)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isAutoPlay, isAutoPlay) || other.isAutoPlay == isAutoPlay)&&(identical(other.isNextAvailable, isNextAvailable) || other.isNextAvailable == isNextAvailable)&&(identical(other.isPreviousAvailable, isPreviousAvailable) || other.isPreviousAvailable == isPreviousAvailable)&&(identical(other.isShuffleEnabled, isShuffleEnabled) || other.isShuffleEnabled == isShuffleEnabled)&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&(identical(other.audioSpeed, audioSpeed) || other.audioSpeed == audioSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,loadingStatus,const DeepCollectionEquality().hash(album),audioContent,failure,isAutoPlay,isNextAvailable,isPreviousAvailable,isShuffleEnabled,loopMode,audioSpeed);

@override
String toString() {
  return 'AudioState(loadingStatus: $loadingStatus, album: $album, audioContent: $audioContent, failure: $failure, isAutoPlay: $isAutoPlay, isNextAvailable: $isNextAvailable, isPreviousAvailable: $isPreviousAvailable, isShuffleEnabled: $isShuffleEnabled, loopMode: $loopMode, audioSpeed: $audioSpeed)';
}


}

/// @nodoc
abstract mixin class $AudioStateCopyWith<$Res>  {
  factory $AudioStateCopyWith(AudioState value, $Res Function(AudioState) _then) = _$AudioStateCopyWithImpl;
@useResult
$Res call({
 AudioLoadingStatus loadingStatus, List<AudioContent>? album, AudioContent? audioContent, Failure? failure, bool isAutoPlay, bool isNextAvailable, bool isPreviousAvailable, bool isShuffleEnabled, LoopMode loopMode, double audioSpeed
});




}
/// @nodoc
class _$AudioStateCopyWithImpl<$Res>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._self, this._then);

  final AudioState _self;
  final $Res Function(AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loadingStatus = null,Object? album = freezed,Object? audioContent = freezed,Object? failure = freezed,Object? isAutoPlay = null,Object? isNextAvailable = null,Object? isPreviousAvailable = null,Object? isShuffleEnabled = null,Object? loopMode = null,Object? audioSpeed = null,}) {
  return _then(_self.copyWith(
loadingStatus: null == loadingStatus ? _self.loadingStatus : loadingStatus // ignore: cast_nullable_to_non_nullable
as AudioLoadingStatus,album: freezed == album ? _self.album : album // ignore: cast_nullable_to_non_nullable
as List<AudioContent>?,audioContent: freezed == audioContent ? _self.audioContent : audioContent // ignore: cast_nullable_to_non_nullable
as AudioContent?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isAutoPlay: null == isAutoPlay ? _self.isAutoPlay : isAutoPlay // ignore: cast_nullable_to_non_nullable
as bool,isNextAvailable: null == isNextAvailable ? _self.isNextAvailable : isNextAvailable // ignore: cast_nullable_to_non_nullable
as bool,isPreviousAvailable: null == isPreviousAvailable ? _self.isPreviousAvailable : isPreviousAvailable // ignore: cast_nullable_to_non_nullable
as bool,isShuffleEnabled: null == isShuffleEnabled ? _self.isShuffleEnabled : isShuffleEnabled // ignore: cast_nullable_to_non_nullable
as bool,loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,audioSpeed: null == audioSpeed ? _self.audioSpeed : audioSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _Playing implements AudioState {
  const _Playing(this.loadingStatus, {final  List<AudioContent>? album, this.audioContent, this.failure, this.isAutoPlay = true, this.isNextAvailable = true, this.isPreviousAvailable = false, this.isShuffleEnabled = false, this.loopMode = LoopMode.off, this.audioSpeed = 1.0}): _album = album;
  

@override final  AudioLoadingStatus loadingStatus;
 final  List<AudioContent>? _album;
@override List<AudioContent>? get album {
  final value = _album;
  if (value == null) return null;
  if (_album is EqualUnmodifiableListView) return _album;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  AudioContent? audioContent;
@override final  Failure? failure;
@override@JsonKey() final  bool isAutoPlay;
@override@JsonKey() final  bool isNextAvailable;
@override@JsonKey() final  bool isPreviousAvailable;
@override@JsonKey() final  bool isShuffleEnabled;
@override@JsonKey() final  LoopMode loopMode;
@override@JsonKey() final  double audioSpeed;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayingCopyWith<_Playing> get copyWith => __$PlayingCopyWithImpl<_Playing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Playing&&(identical(other.loadingStatus, loadingStatus) || other.loadingStatus == loadingStatus)&&const DeepCollectionEquality().equals(other._album, _album)&&(identical(other.audioContent, audioContent) || other.audioContent == audioContent)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.isAutoPlay, isAutoPlay) || other.isAutoPlay == isAutoPlay)&&(identical(other.isNextAvailable, isNextAvailable) || other.isNextAvailable == isNextAvailable)&&(identical(other.isPreviousAvailable, isPreviousAvailable) || other.isPreviousAvailable == isPreviousAvailable)&&(identical(other.isShuffleEnabled, isShuffleEnabled) || other.isShuffleEnabled == isShuffleEnabled)&&(identical(other.loopMode, loopMode) || other.loopMode == loopMode)&&(identical(other.audioSpeed, audioSpeed) || other.audioSpeed == audioSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,loadingStatus,const DeepCollectionEquality().hash(_album),audioContent,failure,isAutoPlay,isNextAvailable,isPreviousAvailable,isShuffleEnabled,loopMode,audioSpeed);

@override
String toString() {
  return 'AudioState.playing(loadingStatus: $loadingStatus, album: $album, audioContent: $audioContent, failure: $failure, isAutoPlay: $isAutoPlay, isNextAvailable: $isNextAvailable, isPreviousAvailable: $isPreviousAvailable, isShuffleEnabled: $isShuffleEnabled, loopMode: $loopMode, audioSpeed: $audioSpeed)';
}


}

/// @nodoc
abstract mixin class _$PlayingCopyWith<$Res> implements $AudioStateCopyWith<$Res> {
  factory _$PlayingCopyWith(_Playing value, $Res Function(_Playing) _then) = __$PlayingCopyWithImpl;
@override @useResult
$Res call({
 AudioLoadingStatus loadingStatus, List<AudioContent>? album, AudioContent? audioContent, Failure? failure, bool isAutoPlay, bool isNextAvailable, bool isPreviousAvailable, bool isShuffleEnabled, LoopMode loopMode, double audioSpeed
});




}
/// @nodoc
class __$PlayingCopyWithImpl<$Res>
    implements _$PlayingCopyWith<$Res> {
  __$PlayingCopyWithImpl(this._self, this._then);

  final _Playing _self;
  final $Res Function(_Playing) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loadingStatus = null,Object? album = freezed,Object? audioContent = freezed,Object? failure = freezed,Object? isAutoPlay = null,Object? isNextAvailable = null,Object? isPreviousAvailable = null,Object? isShuffleEnabled = null,Object? loopMode = null,Object? audioSpeed = null,}) {
  return _then(_Playing(
null == loadingStatus ? _self.loadingStatus : loadingStatus // ignore: cast_nullable_to_non_nullable
as AudioLoadingStatus,album: freezed == album ? _self._album : album // ignore: cast_nullable_to_non_nullable
as List<AudioContent>?,audioContent: freezed == audioContent ? _self.audioContent : audioContent // ignore: cast_nullable_to_non_nullable
as AudioContent?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,isAutoPlay: null == isAutoPlay ? _self.isAutoPlay : isAutoPlay // ignore: cast_nullable_to_non_nullable
as bool,isNextAvailable: null == isNextAvailable ? _self.isNextAvailable : isNextAvailable // ignore: cast_nullable_to_non_nullable
as bool,isPreviousAvailable: null == isPreviousAvailable ? _self.isPreviousAvailable : isPreviousAvailable // ignore: cast_nullable_to_non_nullable
as bool,isShuffleEnabled: null == isShuffleEnabled ? _self.isShuffleEnabled : isShuffleEnabled // ignore: cast_nullable_to_non_nullable
as bool,loopMode: null == loopMode ? _self.loopMode : loopMode // ignore: cast_nullable_to_non_nullable
as LoopMode,audioSpeed: null == audioSpeed ? _self.audioSpeed : audioSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
