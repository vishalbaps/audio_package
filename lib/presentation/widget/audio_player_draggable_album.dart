import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/sliver_utils.dart';

class AudioPlayerDraggableAlbum extends StatelessWidget {
  final BoxDecoration? decoration;
  final Color containerColor;
  final double radius;

  const AudioPlayerDraggableAlbum({
    super.key,
    this.decoration,
    this.containerColor = Colors.blueGrey,
    this.radius = 25,
  });

  @override
  Widget build(BuildContext context) {
    final DraggableScrollableController sheetController = DraggableScrollableController();

    return BlocBuilder<AudioBloc, AudioState>(
      builder: (BuildContext context, AudioState state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.1,
          minChildSize: 0.1,
          controller: sheetController,
          builder: (BuildContext context, scrollController) {
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration:
                  decoration ??
                  BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ),
                  ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.only(top: 20),
                      ),
                    ),
                  ),
                  makeHeader(
                    "Up Next",
                    onPress: () {
                      sheetController.animateTo(
                        0.8,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.bounceIn,
                      );
                    },
                    color: containerColor,
                  ),
                  SliverList.list(children: [AudioPlayerTile(album: state.album ?? [])]),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
