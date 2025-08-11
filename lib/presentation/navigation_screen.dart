import 'package:audio_player_package/presentation/widget/mini_player_bottom.dart';
import 'package:audio_player_package/presentation/widget/mini_player_top.dart';
import 'package:audio_player_package/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/audio_bloc.dart';
import '../models/audio_content.dart';

class NavigationScreen extends StatelessWidget {
  final void Function(List<AudioContent> album, AudioContent track)? onMiniPlayerTap;
  final void Function(List<AudioContent> album, AudioContent track)? onTapQueueIcon;
  final void Function(List<AudioContent> album, AudioContent track)? onTapTopView;
  final MiniPlayerType miniPlayerType;
  final Widget child;
  final PreferredSizeWidget? appbar;
  final bool isShowAutoPlaySwitch;
  final Text? title;

  const NavigationScreen({
    super.key,
    this.onMiniPlayerTap,
    this.onTapQueueIcon,
    this.miniPlayerType = MiniPlayerType.bottom,
    this.appbar,
    required this.child,
    this.onTapTopView,
    this.isShowAutoPlaySwitch = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (context, state) {
        final isAudioActive = state.loadingStatus != AudioLoadingStatus.none;
        final miniPlayerBottom = MiniPlayerBottom(
          onTapView: (album, track) => onMiniPlayerTap?.call(album, track),
          onTapQueueIcon: (album, track) => onTapQueueIcon?.call(album, track),
          tileCornerRadius: 15,
        );

        final miniPlayerTop = MiniPlayerTop(onTap: (album, track) => onTapTopView?.call(album, track));
        return Scaffold(
          appBar: AppBar(
            title: title,
            actions:
                isShowAutoPlaySwitch
                    ? [
                      Switch(
                        value: state.isAutoPlay,
                        onChanged: (value) {
                          context.read<AudioBloc>().add(AudioEventAutoPlay(value));
                        },
                      ),
                    ]
                    : null,
          ),
          body: Column(
            children: [
              if (miniPlayerType == MiniPlayerType.top && isAudioActive) miniPlayerTop,
              Expanded(child: Container(width: double.infinity, alignment: Alignment.topLeft, child: child)),
              if (miniPlayerType == MiniPlayerType.bottom && isAudioActive) miniPlayerBottom,
            ],
          ),
        );
      },
    );
  }
}
