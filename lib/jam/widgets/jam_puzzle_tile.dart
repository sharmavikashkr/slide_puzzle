import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/audio_control/audio_control.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/helpers/helpers.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/models/models.dart';
import 'package:jam_slide_puzzle/puzzle/puzzle.dart';
import 'package:just_audio/just_audio.dart';

abstract class _TileSize {
  static double small = 75;
  static double medium = 90;
  static double large = 112;
}

/// {@template jam_puzzle_tile}
/// Displays the puzzle tile associated with [tile]
/// based on the puzzle [state].
/// {@endtemplate}
class JamPuzzleTile extends StatefulWidget {
  /// {@macro jam_puzzle_tile}
  const JamPuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
    AudioPlayerFactory? audioPlayer,
  })  : _audioPlayerFactory = audioPlayer ?? getAudioPlayer,
        super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  final AudioPlayerFactory _audioPlayerFactory;

  @override
  State<JamPuzzleTile> createState() => _JamPuzzleTileState();
}

class _JamPuzzleTileState extends State<JamPuzzleTile> {
  AudioPlayer? _audioPlayer;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();

    // Delay the initialization of the audio player for performance reasons,
    // to avoid dropping frames when the theme is changed.
    _timer = Timer(const Duration(seconds: 1), () {
      _audioPlayer = widget._audioPlayerFactory()
        ..setAsset('assets/audio/tile_move.mp3');
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _audioPlayer?.dispose();
    super.dispose();
  }

  Widget __transitionBuilder(Widget widget, Animation<double> animation) {
    if (!this.widget.tile.flip) {
      return widget;
    }
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final value = min(rotateAnim.value, pi / 2);
        return Transform(
          transform: Matrix4.rotationY(value),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();
    final theme = context.select((JamThemeBloc bloc) => bloc.state.theme);
    final status = context.select((JamPuzzleBloc bloc) => bloc.state.status);
    final hasStarted = status == JamPuzzleStatus.started;

    final movementDuration = status == JamPuzzleStatus.loading
        ? const Duration(milliseconds: 800)
        : const Duration(milliseconds: 370);

    return AudioControlListener(
      audioPlayer: _audioPlayer,
      child: AnimatedAlign(
        alignment: FractionalOffset(
          (widget.tile.currentPosition.x - 1) / (size - 1),
          (widget.tile.currentPosition.y - 1) / (size - 1),
        ),
        duration: movementDuration,
        curve: Curves.easeInOut,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: __transitionBuilder,
          child: ResponsiveLayoutBuilder(
            key: ValueKey(Random().nextDouble()),
            small: (_, child) => SizedBox.square(
              key: Key('jam_puzzle_tile_small_${widget.tile.value}'),
              dimension: _TileSize.small,
              child: child,
            ),
            medium: (_, child) => SizedBox.square(
              key: Key('jam_puzzle_tile_medium_${widget.tile.value}'),
              dimension: _TileSize.medium,
              child: child,
            ),
            large: (_, child) => SizedBox.square(
              key: Key('jam_puzzle_tile_large_${widget.tile.value}'),
              dimension: _TileSize.large,
              child: child,
            ),
            child: (_) => TextButton(
              style: TextButton.styleFrom(
                primary: PuzzleColors.black,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                backgroundColor: theme.defaultColor,
              ),
              onPressed: hasStarted
                  ? () {
                      context.read<PuzzleBloc>().add(TileTapped(widget.tile));
                      unawaited(_audioPlayer?.replay());
                    }
                  : null,
              child: ResponsiveLayoutBuilder(
                small: (_, child) => SizedBox.square(
                  key: Key(
                    'jam_puzzle_tile_tile_icon_small_${widget.tile.value}',
                  ),
                  dimension: 30,
                  child: child,
                ),
                medium: (_, child) => SizedBox.square(
                  key: Key(
                    'jam_puzzle_tile_tile_icon_small_${widget.tile.value}',
                  ),
                  dimension: 40,
                  child: child,
                ),
                large: (_, child) => SizedBox.square(
                  key: Key(
                    'jam_puzzle_tile_tile_icon_small_${widget.tile.value}',
                  ),
                  dimension: 50,
                  child: child,
                ),
                child: (_) => FittedBox(
                  fit: BoxFit.fill,
                  child: Icon(
                    widget.tile.icon,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
