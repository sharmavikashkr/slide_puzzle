import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/puzzle/puzzle.dart';
import 'package:jam_slide_puzzle/theme/themes/themes.dart';
import 'package:jam_slide_puzzle/theme/widgets/widgets.dart';
import 'package:jam_slide_puzzle/typography/typography.dart';

/// {@template jam_score}
/// Displays the score of the solved Jam puzzle.
/// {@endtemplate}
class JamScore extends StatelessWidget {
  /// {@macro jam_score}
  const JamScore({Key? key}) : super(key: key);

  static const _smallImageOffset = Offset(100, 0);
  static const _mediumImageOffset = Offset(175, -47);
  static const _largeImageOffset = Offset(175, -47);

  @override
  Widget build(BuildContext context) {
    final theme = context.select((JamThemeBloc bloc) => bloc.state.theme);
    final state = context.watch<PuzzleBloc>().state;
    final l10n = context.l10n;

    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => child!,
      child: (currentSize) {
        final height =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 355.0;

        final imageOffset = currentSize == ResponsiveLayoutSize.large
            ? _largeImageOffset
            : (currentSize == ResponsiveLayoutSize.medium
                ? _mediumImageOffset
                : _smallImageOffset);

        final imageHeight =
            currentSize == ResponsiveLayoutSize.small ? 374.0 : 437.0;

        final completedTextWidth =
            currentSize == ResponsiveLayoutSize.small ? 160.0 : double.infinity;

        final wellDoneTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline4Soft
            : PuzzleTextStyle.headline3;

        final timerTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        final timerIconSize = currentSize == ResponsiveLayoutSize.small
            ? const Size(21, 21)
            : const Size(28, 28);

        final timerIconPadding =
            currentSize == ResponsiveLayoutSize.small ? 4.0 : 6.0;

        final numberOfMovesTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.headline5
            : PuzzleTextStyle.headline4;

        return ClipRRect(
          key: const Key('jam_score'),
          borderRadius: BorderRadius.circular(22),
          child: Container(
            width: double.infinity,
            height: height,
            color: theme.backgroundColor,
            child: Stack(
              children: [
                Positioned(
                  left: imageOffset.dx,
                  top: imageOffset.dy,
                  child: Image.asset(
                    theme.successThemeAsset,
                    height: imageHeight,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppFlutterLogo(
                        height: 18,
                        isColored: false,
                      ),
                      const ResponsiveGap(
                        small: 24,
                        medium: 32,
                        large: 32,
                      ),
                      SizedBox(
                        key: const Key('jam_score_completed'),
                        width: completedTextWidth,
                        child: AnimatedDefaultTextStyle(
                          style: PuzzleTextStyle.headline5.copyWith(
                            color: theme.defaultColor,
                          ),
                          duration: PuzzleThemeAnimationDuration.textStyle,
                          child: Text(l10n.jamSuccessCompleted),
                        ),
                      ),
                      const ResponsiveGap(
                        small: 8,
                        medium: 16,
                        large: 16,
                      ),
                      AnimatedDefaultTextStyle(
                        key: const Key('jam_score_well_done'),
                        style: wellDoneTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(l10n.jamSuccessWellDone),
                      ),
                      const ResponsiveGap(
                        small: 24,
                        medium: 32,
                        large: 32,
                      ),
                      AnimatedDefaultTextStyle(
                        key: const Key('jam_score'),
                        style: numberOfMovesTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(
                          l10n.jamSuccessScore(
                            state.score.toString(),
                          ),
                        ),
                      ),
                      const ResponsiveGap(
                        small: 2,
                        medium: 8,
                        large: 8,
                      ),
                      AnimatedDefaultTextStyle(
                        key: const Key('jam_score_number_of_moves'),
                        style: numberOfMovesTextStyle.copyWith(
                          color: PuzzleColors.white,
                        ),
                        duration: PuzzleThemeAnimationDuration.textStyle,
                        child: Text(
                          l10n.jamSuccessNumberOfMoves(
                            state.numberOfMoves.toString(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
