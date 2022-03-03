import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';
import 'package:jam_slide_puzzle/typography/typography.dart';
import 'package:spring/spring.dart';

/// {@template number_of_moves_and_tiles_left}
/// Displays how many moves have been made on the current puzzle
/// and how many puzzle tiles are not in their correct position.
/// {@endtemplate}
class NumberOfMovesAndScore extends StatelessWidget {
  /// {@macro number_of_moves_and_tiles_left}
  const NumberOfMovesAndScore({
    Key? key,
    required this.numberOfMoves,
    required this.score,
    this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The current score
  final int score;

  /// The color of texts that display [numberOfMoves] and [score].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.select((JamThemeBloc bloc) => bloc.state.theme);
    final l10n = context.l10n;
    final textColor = color ?? theme.defaultColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      child: (currentSize) {
        final mainAxisAlignment = currentSize == ResponsiveLayoutSize.large
            ? MainAxisAlignment.start
            : MainAxisAlignment.center;

        final bodyTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.body;

        return Semantics(
          label: l10n.puzzleNumberOfMovesAndScoreText(
            numberOfMoves.toString(),
            score.toString(),
          ),
          child: ExcludeSemantics(
            child: Spring.bubbleButton(
              child: Row(
                key: const Key('number_of_moves_and_score'),
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  AnimatedDefaultTextStyle(
                    key: const Key('number_of_moves'),
                    style: PuzzleTextStyle.headline4.copyWith(
                      color: textColor,
                    ),
                    duration: PuzzleThemeAnimationDuration.textStyle,
                    child: Text(numberOfMoves.toString()),
                  ),
                  AnimatedDefaultTextStyle(
                    style: PuzzleTextStyle.headline4.copyWith(
                      color: textColor,
                    ),
                    duration: PuzzleThemeAnimationDuration.textStyle,
                    child: Text(' ${l10n.puzzleNumberOfMoves} | '),
                  ),
                  AnimatedDefaultTextStyle(
                    style: PuzzleTextStyle.headline4.copyWith(
                      color: textColor,
                    ),
                    duration: PuzzleThemeAnimationDuration.textStyle,
                    child: Text(' ${l10n.score}'),
                  ),
                  AnimatedDefaultTextStyle(
                    style: PuzzleTextStyle.headline4.copyWith(
                      color: textColor,
                    ),
                    duration: PuzzleThemeAnimationDuration.textStyle,
                    child: Text(score.toString()),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
