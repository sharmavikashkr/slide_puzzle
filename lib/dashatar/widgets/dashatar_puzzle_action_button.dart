import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:very_good_slide_puzzle/audio_control/audio_control.dart';
import 'package:very_good_slide_puzzle/dashatar/dashatar.dart';
import 'package:very_good_slide_puzzle/helpers/helpers.dart';
import 'package:very_good_slide_puzzle/l10n/l10n.dart';
import 'package:very_good_slide_puzzle/theme/theme.dart';

/// {@template dashatar_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class DashatarPuzzleActionButton extends StatefulWidget {
  /// {@macro dashatar_puzzle_action_button}
  const DashatarPuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<DashatarPuzzleActionButton> createState() =>
      _DashatarPuzzleActionButtonState();
}

class _DashatarPuzzleActionButtonState
    extends State<DashatarPuzzleActionButton> {
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

    final status =
        context.select((DashatarPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == DashatarPuzzleStatus.loading;
    final isStarted = status == DashatarPuzzleStatus.started;
    final isStopped = status == DashatarPuzzleStatus.stopped;

    final text = isLoading
        ? context.l10n.dashatarGetReady
        : (isStarted
            ? context.l10n.dashatarStop
            : (isStopped
                ? context.l10n.dashatarRestart
                : context.l10n.dashatarStartGame));

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Tooltip(
          key: ValueKey(status),
          message: isStarted ? context.l10n.puzzleRestartTooltip : '',
          verticalOffset: 40,
          child: PuzzleButton(
            onPressed: isLoading
                ? null
                : isStarted
                    ? () async {
                        context.read<DashatarPuzzleBloc>().add(
                              const DashatarGameCountdownStopped(),
                            );
                        unawaited(_audioPlayer.replay());
                      }
                    : () async {
                        context.read<DashatarPuzzleBloc>().add(
                              const DashatarCountdownReset(),
                            );
                        unawaited(_audioPlayer.replay());
                      },
            textColor: isLoading ? theme.defaultColor : null,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
