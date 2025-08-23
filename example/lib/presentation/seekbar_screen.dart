import 'package:audio_player_package/audio_player_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/seekbar_bloc.dart';
import 'menu_list_screen.dart';

class SeekbarScreen extends StatelessWidget {
  static String id = "seekbar";
  static String path = "${MenuListScreen.path}/$id";

  const SeekbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SeekBar"),
        ),
        body: BlocBuilder<SeekBarBloc, SeekBarState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Slider(
                    value: state.playPosition,
                    padding: EdgeInsets.zero,
                    onChanged: (double value) async {
                      if (!state.isUserSeek) {
                        context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(true));
                      }
                      var newCurrentDuration = Duration(seconds: (state.totalDuration.inSeconds * value).toInt());
                      context.read<SeekBarBloc>().add(SeekBarSetCurrentDurationEvent(newCurrentDuration));
                    },
                    onChangeStart: (_) {
                      context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(true));
                    },
                    onChangeEnd: (value) {
                      context.read<SeekBarBloc>().add(SeekBarUserSeekEvent(false));

                      var newCurrentDuration = Duration(seconds: (state.totalDuration.inSeconds * value).ceil());
                      context.read<SeekBarBloc>().add(SeekBarSetCurrentDurationEvent(newCurrentDuration));
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        state.currentDuration.toHHMMSS(),
                      ),
                      Text(
                        state.totalDuration.toHHMMSS(),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                ],
              ),
            );
          },
        ));
  }
}
