// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_player_package/src/bloc/audio_bloc.dart' as _i904;
import 'package:audio_player_package/src/bloc/slider_seek_bloc.dart' as _i1056;
import 'package:audio_player_package/src/register_module.dart' as _i537;
import 'package:audio_player_package/src/utils/audio_manager.dart' as _i94;
import 'package:audio_player_package/src/utils/connections.dart' as _i1036;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singletonAsync<_i94.AudioManager>(() => registerModule.audioManager);
    gh.singleton<_i1036.InternetConnectivity>(
      () => registerModule.internetConnectivity,
    );
    gh.singletonAsync<_i1056.SliderSeekBloc>(
      () async => _i1056.SliderSeekBloc(await getAsync<_i94.AudioManager>()),
    );
    gh.singletonAsync<_i904.AudioBloc>(
      () async => _i904.AudioBloc(
        await getAsync<_i94.AudioManager>(),
        gh<_i1036.InternetConnectivity>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i537.RegisterModule {}
