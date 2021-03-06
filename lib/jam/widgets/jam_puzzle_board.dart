import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:spring/spring.dart';

abstract class _BoardSize {
  static double small = 312;
  static double medium = 380;
  static double large = 472;
}

/// {@template jam_puzzle_board}
/// Displays the board of the puzzle in a [Stack] filled with [tiles].
/// {@endtemplate}
class JamPuzzleBoard extends StatefulWidget {
  /// {@macro jam_puzzle_board}
  const JamPuzzleBoard({
    Key? key,
    required this.tiles,
    required this.icons,
  }) : super(key: key);

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The icons to be displayed on the board.
  final List<Widget> icons;

  @override
  State<JamPuzzleBoard> createState() => _JamPuzzleBoardState();
}

class _JamPuzzleBoardState extends State<JamPuzzleBoard> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox.square(
            key: const Key('jam_puzzle_board_small'),
            dimension: _BoardSize.small,
            child: child,
          ),
          medium: (_, child) => SizedBox.square(
            key: const Key('jam_puzzle_board_medium'),
            dimension: _BoardSize.medium,
            child: child,
          ),
          large: (_, child) => SizedBox.square(
            key: const Key('jam_puzzle_board_large'),
            dimension: _BoardSize.large,
            child: child,
          ),
          child: (_) => Stack(children: widget.tiles),
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => SizedBox(
            key: const Key('jam_puzzle_icons_small'),
            height: _BoardSize.small,
            width: 50,
            child: child,
          ),
          medium: (_, child) => SizedBox(
            key: const Key('jam_puzzle_icons_medium'),
            height: _BoardSize.medium,
            width: 75,
            child: child,
          ),
          large: (_, child) => SizedBox(
            key: const Key('jam_puzzle_icons_large'),
            height: _BoardSize.large,
            width: 100,
            child: child,
          ),
          child: (_) => Stack(children: widget.icons),
        )
      ],
    );
  }
}
