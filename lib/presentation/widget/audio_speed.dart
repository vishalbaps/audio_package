import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/audio_bloc.dart';
import '../../utils/constants.dart';

class AudioSpeed extends StatelessWidget {
  final Color? selectedChipColor;
  final Color? selectedChipTextColor;
  final Color? deSelectedChipTextColor;
  final Color? checkMarkColor;

  const AudioSpeed({
    super.key,
    this.selectedChipColor = Colors.blue,
    this.selectedChipTextColor = Colors.white,
    this.deSelectedChipTextColor = Colors.black,
    this.checkMarkColor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioBloc, AudioState>(
      builder: (BuildContext context, AudioState state) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:
                AudioConsts.audioSpeeds.map((speed) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      checkmarkColor: checkMarkColor,
                      label: Text('${speed}x'),
                      selected: state.audioSpeed == speed,
                      onSelected: (bool selected) {
                        context.read<AudioBloc>().add(AudioEventAudioSpeed(speed));
                      },
                      selectedColor: selectedChipColor,
                      labelStyle: TextStyle(
                        color: state.audioSpeed == speed ? selectedChipTextColor : deSelectedChipTextColor,
                      ),
                    ),
                  );
                }).toList(),
          ),
        );
      },
    );
  }
}
