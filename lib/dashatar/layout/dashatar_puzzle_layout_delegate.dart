import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jam_slide_puzzle/dashatar/dashatar.dart';
import 'package:jam_slide_puzzle/dashatar/widgets/dashatar_puzzle_icon.dart';
import 'package:jam_slide_puzzle/dashatar/widgets/dashatar_share_dialog_button.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/models/models.dart';
import 'package:jam_slide_puzzle/puzzle/puzzle.dart';

/// {@template dashatar_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [DashatarTheme].
/// {@endtemplate}

class DashatarPuzzleLayoutDelegate extends PuzzleLayoutDelegate {
  /// {@macro dashatar_puzzle_layout_delegate}
  const DashatarPuzzleLayoutDelegate();

  @override
  Widget startSectionBuilder(PuzzleState state) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: DashatarStartSection(state: state),
      ),
      medium: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 150, right: 150),
        child: DashatarStartSection(state: state),
      ),
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: DashatarStartSection(state: state),
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
              DashatarPuzzleActionButton(),
              Gap(10),
              DashatarShareDialogButton(),
            ],
          ),
          medium: (_, child) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              DashatarPuzzleActionButton(),
              Gap(20),
              DashatarShareDialogButton(),
            ],
          ),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => const DashatarThemePicker(),
          medium: (_, child) => const DashatarThemePicker(),
          large: (_, child) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 54,
        ),
        const ResponsiveGap(
          large: 130,
        ),
        const DashatarCountdown(),
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
        large: (_, child) => const DashatarThemePicker(),
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
            large: (_, child) => const DashatarTimer(),
          ),
        ),
        Column(
          children: [
            const ResponsiveGap(
              small: 21,
              medium: 34,
              large: 96,
            ),
            DashatarPuzzleBoard(tiles: tiles, icons: icons),
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
    return DashatarPuzzleTile(
      tile: tile,
      state: state,
    );
  }

  @override
  Widget iconBuilder(int index, PuzzleState state) {
    return DashatarPuzzleIcon(
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
