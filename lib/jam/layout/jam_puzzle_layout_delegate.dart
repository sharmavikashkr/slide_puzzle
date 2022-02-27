import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/models/models.dart';
import 'package:jam_slide_puzzle/puzzle/puzzle.dart';

/// {@template jam_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [JamTheme].
/// {@endtemplate}

class JamPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro jam_puzzle_layout_delegate}
  const JamPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: JamStartSection(state: state),
      ),
      medium: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 150, right: 150),
        child: JamStartSection(state: state),
      ),
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: JamStartSection(state: state),
      ),
    );
  }

  @override
  Widget endSectionBuilder(PuzzleState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ResponsiveGap(
          small: 23,
          medium: 32,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              JamPuzzleActionButton(),
              Gap(10),
              JamShareDialogButton(),
            ],
          ),
          medium: (_, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              JamPuzzleActionButton(),
              Gap(20),
              JamShareDialogButton(),
            ],
          ),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const JamThemePicker(),
          medium: (_, child) => const JamThemePicker(),
          large: (_, child) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const ResponsiveGap(
          large: 130,
        ),
        const JamCountdown(),
      ],
    );
  }

  @override
  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      bottom: 74,
      right: 50,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => const SizedBox(),
        medium: (_, child) => const SizedBox(),
        large: (_, child) => const JamThemePicker(),
      ),
    );
  }

  @override
  Widget boardBuilder(
      PuzzleState state, int size, List<Widget> tiles, List<Widget> icons) {
    return Stack(
      children: [
        Positioned(
          top: 24,
          left: 0,
          right: 0,
          child: ResponsiveLayoutBuilder(
            small: (_, child) => const SizedBox(),
            medium: (_, child) => const SizedBox(),
            large: (_, child) => const JamTimer(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
            JamPuzzleBoard(tiles: tiles, icons: icons),
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return JamPuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget iconBuilder(int index, PuzzleState state) {
    return JamPuzzleIcon(
      index: index,
      state: state,
    );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}
