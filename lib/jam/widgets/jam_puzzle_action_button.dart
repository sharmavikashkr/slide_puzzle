import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/audio_control/audio_control.dart';
import 'package:jam_slide_puzzle/helpers/helpers.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';
import 'package:just_audio/just_audio.dart';

/// {@template jam_puzzle_action_button}
/// Displays the action button to start or shuffle the puzzle
/// based on the current puzzle state.
/// {@endtemplate}
class JamPuzzleActionButton extends StatefulWidget {
  /// {@macro jam_puzzle_action_button}
  const JamPuzzleActionButton({Key? key, AudioPlayerFactory? audioPlayer})
      : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<JamPuzzleActionButton> createState() => _JamPuzzleActionButtonState();
}

class _JamPuzzleActionButtonState extends State<JamPuzzleActionButton> {
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
    final theme = context.select((JamThemeBloc bloc) => bloc.state.theme);

    final status = context.select((JamPuzzleBloc bloc) => bloc.state.status);
    final isLoading = status == JamPuzzleStatus.loading;
    final isStarted = status == JamPuzzleStatus.started;
    final isStopped = status == JamPuzzleStatus.stopped;

    final text = isLoading
        ? context.l10n.jamGetReady
        : (isStarted
            ? context.l10n.jamStop
            : (isStopped
                ? context.l10n.jamRestart
                : context.l10n.jamStartGame));

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
                        context.read<JamPuzzleBloc>().add(
                              const JamGameCountdownStopped(),
                            );
                        unawaited(_audioPlayer.replay());
                      }
                    : () async {
                        context.read<JamPuzzleBloc>().add(
                              const JamCountdownReset(),
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
