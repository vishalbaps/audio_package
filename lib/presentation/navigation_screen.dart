import 'package:audio_player_package/presentation/widget/mini_player_bottom.dart';
import 'package:audio_player_package/presentation/widget/mini_player_top.dart';
import 'package:audio_player_package/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/audio_bloc.dart';
import '../models/audio_content.dart';

class NavigationScreen extends StatelessWidget {
  final void Function(AudioContent track)? onMiniPlayerTap;
  final void Function(List<AudioContent> album, AudioContent track)? onTapQueueIcon;
  final MiniPlayerType miniPlayerType;
  final Widget child;
  final PreferredSizeWidget? appbar;

  const NavigationScreen({
    super.key,
    this.onMiniPlayerTap,
    this.onTapQueueIcon,
    this.miniPlayerType = MiniPlayerType.bottom,
    this.appbar,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: BlocBuilder<AudioBloc, AudioState>(
        builder: (context, state) {
          final isAudioActive = state.loadingStatus != AudioLoadingStatus.none;
          final miniPlayerBottom = MiniPlayerBottom(
            onTapView: (album, track) {},
            onTapQueueIcon: (album, track) {},
            tileCornerRadius: 15,
          );

          final miniPlayerTop = MiniPlayerTop(onTap: (track) {});
          return Column(
            children: [
              if (miniPlayerType == MiniPlayerType.top && isAudioActive) miniPlayerTop,
              Expanded(child: Container(width: double.infinity, alignment: Alignment.topLeft, child: child)),
              if (miniPlayerType == MiniPlayerType.bottom && isAudioActive) miniPlayerBottom,
            ],
          );
        },
      ),
    );
  }
}
