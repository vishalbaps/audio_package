// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_player_package/bloc/audio_bloc.dart' as _i115;
import 'package:audio_player_package/register_module.dart' as _i1026;
import 'package:audio_player_package/utils/audio_manager.dart' as _i632;
import 'package:audio_player_package/utils/connections.dart' as _i147;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import 'bloc/slider_seek_bloc.dart' as _i24;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.singletonAsync<_i632.AudioManager>(
      () => registerModule.audioManager,
      preResolve: true,
    );
    gh.singleton<_i147.InternetConnectivity>(
      () => registerModule.internetConnectivity,
    );
    gh.singleton<_i115.AudioBloc>(
      () => _i115.AudioBloc(
        gh<_i632.AudioManager>(),
        gh<_i147.InternetConnectivity>(),
      ),
    );
    gh.singleton<_i24.SliderSeekBloc>(
            ()  => _i24.SliderSeekBloc(gh<_i632.AudioManager>()));
    return this;
  }
}

class _$RegisterModule extends _i1026.RegisterModule {}
