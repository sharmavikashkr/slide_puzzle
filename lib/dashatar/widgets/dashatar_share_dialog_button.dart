import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

import '../../puzzle/puzzle.dart';

/// {@template dashatar_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class DashatarShareDialogButton extends StatefulWidget {
  /// {@macro dashatar_puzzle_action_button}
  const DashatarShareDialogButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<DashatarShareDialogButton> createState() =>
      _DashatarShareDialogButtonState();
}

class _DashatarShareDialogButtonState extends State<DashatarShareDialogButton> {
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = widget._audioPlayerFactory()
      ..setAsset('assets/audio/click.mp3');
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.select((DashatarThemeBloc bloc) => bloc.state.theme);
    final score = context.select((PuzzleBloc bloc) => bloc.state.score);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(Random().nextDouble()),
          message: context.l10n.dashatarShare,
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: score > 0
                ? () async {
                    context.read<DashatarPuzzleBloc>().add(
                          const DashatarGameCountdownStopped(),
                        );
                    unawaited(_audioPlayer.replay());
                    await showAppDialog<void>(
                      context: context,
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: context.read<DashatarThemeBloc>(),
                          ),
                          BlocProvider.value(
                            value: context.read<DashatarPuzzleBloc>(),
                          ),
                          BlocProvider.value(
                            value: context.read<PuzzleBloc>(),
                          ),
                          BlocProvider.value(
                            value: context.read<AudioControlBloc>(),
                          ),
                        ],
                        child: const DashatarShareDialog(),
                      ),
                    );
                  }
                : null,
            child: Text(context.l10n.dashatarShare),
          ),
        ),
      ),
    );
  }
}
