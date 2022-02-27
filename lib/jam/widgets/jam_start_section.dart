import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/puzzle/puzzle.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';
import 'package:jam_slide_puzzle/theme/widgets/puzzle_subtitle.dart';

/// {@template jam_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
class JamStartSection extends StatelessWidget {
  /// {@macro jam_start_section}
  const JamStartSection({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        PuzzleName(
          key: puzzleNameKey,
        ),
        const ResponsiveGap(large: 16),
        PuzzleTitle(
          key: puzzleTitleKey,
          title: context.l10n.puzzleChallengeTitle,
        ),
        const ResponsiveGap(large: 8),
        PuzzleSubTitle(
          key: puzzleSubTitleKey,
          title: context.l10n.puzzleChallengeSubTitle,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMovesAndScore(
          key: numberOfMovesAndTilesLeftKey,
          numberOfMoves: state.numberOfMoves,
          score: state.score,
        ),
        const ResponsiveGap(
          small: 8,
          medium: 18,
          large: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              JamPuzzleActionButton(),
              Gap(20),
              JamShareDialogButton(),
            ],
          ),
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => const JamTimer(),
          medium: (_, __) => const JamTimer(),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(small: 12),
      ],
    );
  }
}
