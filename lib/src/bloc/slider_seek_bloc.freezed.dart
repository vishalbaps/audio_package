// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slider_seek_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SliderSeekState {

 Duration get currentDuration; Duration get totalDuration; bool get isUserSeek; double get playPosition;
/// Create a copy of SliderSeekState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SliderSeekStateCopyWith<SliderSeekState> get copyWith => _$SliderSeekStateCopyWithImpl<SliderSeekState>(this as SliderSeekState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SliderSeekState&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.isUserSeek, isUserSeek) || other.isUserSeek == isUserSeek)&&(identical(other.playPosition, playPosition) || other.playPosition == playPosition));
}


@override
int get hashCode => Object.hash(runtimeType,currentDuration,totalDuration,isUserSeek,playPosition);

@override
String toString() {
  return 'SliderSeekState(currentDuration: $currentDuration, totalDuration: $totalDuration, isUserSeek: $isUserSeek, playPosition: $playPosition)';
}


}

/// @nodoc
abstract mixin class $SliderSeekStateCopyWith<$Res>  {
  factory $SliderSeekStateCopyWith(SliderSeekState value, $Res Function(SliderSeekState) _then) = _$SliderSeekStateCopyWithImpl;
@useResult
$Res call({
 Duration currentDuration, Duration totalDuration, bool isUserSeek, double playPosition
});




}
/// @nodoc
class _$SliderSeekStateCopyWithImpl<$Res>
    implements $SliderSeekStateCopyWith<$Res> {
  _$SliderSeekStateCopyWithImpl(this._self, this._then);

  final SliderSeekState _self;
  final $Res Function(SliderSeekState) _then;

/// Create a copy of SliderSeekState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentDuration = null,Object? totalDuration = null,Object? isUserSeek = null,Object? playPosition = null,}) {
  return _then(_self.copyWith(
currentDuration: null == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as Duration,totalDuration: null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,isUserSeek: null == isUserSeek ? _self.isUserSeek : isUserSeek // ignore: cast_nullable_to_non_nullable
as bool,playPosition: null == playPosition ? _self.playPosition : playPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc


class _SliderSeekState implements SliderSeekState {
  const _SliderSeekState(this.currentDuration, this.totalDuration, this.isUserSeek, this.playPosition);
  

@override final  Duration currentDuration;
@override final  Duration totalDuration;
@override final  bool isUserSeek;
@override final  double playPosition;

/// Create a copy of SliderSeekState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SliderSeekStateCopyWith<_SliderSeekState> get copyWith => __$SliderSeekStateCopyWithImpl<_SliderSeekState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SliderSeekState&&(identical(other.currentDuration, currentDuration) || other.currentDuration == currentDuration)&&(identical(other.totalDuration, totalDuration) || other.totalDuration == totalDuration)&&(identical(other.isUserSeek, isUserSeek) || other.isUserSeek == isUserSeek)&&(identical(other.playPosition, playPosition) || other.playPosition == playPosition));
}


@override
int get hashCode => Object.hash(runtimeType,currentDuration,totalDuration,isUserSeek,playPosition);

@override
String toString() {
  return 'SliderSeekState(currentDuration: $currentDuration, totalDuration: $totalDuration, isUserSeek: $isUserSeek, playPosition: $playPosition)';
}


}

/// @nodoc
abstract mixin class _$SliderSeekStateCopyWith<$Res> implements $SliderSeekStateCopyWith<$Res> {
  factory _$SliderSeekStateCopyWith(_SliderSeekState value, $Res Function(_SliderSeekState) _then) = __$SliderSeekStateCopyWithImpl;
@override @useResult
$Res call({
 Duration currentDuration, Duration totalDuration, bool isUserSeek, double playPosition
});




}
/// @nodoc
class __$SliderSeekStateCopyWithImpl<$Res>
    implements _$SliderSeekStateCopyWith<$Res> {
  __$SliderSeekStateCopyWithImpl(this._self, this._then);

  final _SliderSeekState _self;
  final $Res Function(_SliderSeekState) _then;

/// Create a copy of SliderSeekState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentDuration = null,Object? totalDuration = null,Object? isUserSeek = null,Object? playPosition = null,}) {
  return _then(_SliderSeekState(
null == currentDuration ? _self.currentDuration : currentDuration // ignore: cast_nullable_to_non_nullable
as Duration,null == totalDuration ? _self.totalDuration : totalDuration // ignore: cast_nullable_to_non_nullable
as Duration,null == isUserSeek ? _self.isUserSeek : isUserSeek // ignore: cast_nullable_to_non_nullable
as bool,null == playPosition ? _self.playPosition : playPosition // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
