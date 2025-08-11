// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:audio_player_package/bloc/audio_bloc.dart' as _i115;
import 'package:audio_player_package/bloc/slider_seek_bloc.dart' as _i1047;
import 'package:audio_player_package/register_module.dart' as _i1026;
import 'package:audio_player_package/utils/audio_manager.dart' as _i632;
import 'package:audio_player_package/utils/connections.dart' as _i147;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singletonAsync<_i632.AudioManager>(() => registerModule.audioManager);
    gh.singleton<_i147.InternetConnectivity>(
      () => registerModule.internetConnectivity,
    );
    gh.singletonAsync<_i1047.SliderSeekBloc>(
      () async => _i1047.SliderSeekBloc(await getAsync<_i632.AudioManager>()),
    );
    gh.singletonAsync<_i115.AudioBloc>(
      () async => _i115.AudioBloc(
        await getAsync<_i632.AudioManager>(),
        gh<_i147.InternetConnectivity>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i1026.RegisterModule {}
