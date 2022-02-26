import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

import '../../puzzle/bloc/puzzle_bloc.dart';
import '../bloc/dashatar_puzzle_bloc.dart';
import '../bloc/dashatar_theme_bloc.dart';

abstract class _IconSize {
  static double small = 30;
  static double medium = 45;
  static double large = 60;
}

abstract class _BoxHeight {
  static double small = 75;
  static double medium = 90;
  static double large = 118;
}

abstract class _BoxWidth {
  static double small = 50;
  static double medium = 75;
  static double large = 100;
}

/// {@template dashatar_puzzle_Icon}
/// Displays the board of the puzzle in a [Stack].
/// {@endtemplate}
class DashatarPuzzleIcon extends StatefulWidget {
  /// {@macro dashatar_puzzle_Icon}
  const DashatarPuzzleIcon({
    Key? key,
    required this.index,
    required this.state,
  }) : super(key: key);

  /// the index of state icons in this widget
  final int index;

  /// the current PuzzleState
  final PuzzleState state;

  @override
  State<DashatarPuzzleIcon> createState() => DashatarPuzzleIconState();
}

@visibleForTesting
class DashatarPuzzleIconState extends State<DashatarPuzzleIcon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.state.puzzle.getDimension();

    return AnimatedAlign(
      alignment: FractionalOffset(
        0,
        widget.index / (size - 1),
      ),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInExpo,
      child: ResponsiveLayoutBuilder(
        small: (_, child) => SizedBox(
          key: Key('dashatar_puzzle_icon_small_${widget.index}'),
          height: _BoxHeight.small,
          width: _BoxWidth.small,
          child: child,
        ),
        medium: (_, child) => SizedBox(
          key: Key('dashatar_puzzle_icon_medium_${widget.index}'),
          height: _BoxHeight.medium,
          width: _BoxWidth.medium,
          child: child,
        ),
        large: (_, child) => SizedBox(
          key: Key('dashatar_puzzle_icon_large_${widget.index}'),
          height: _BoxHeight.large,
          width: _BoxWidth.large,
          child: child,
        ),
        child: (_) => ResponsiveLayoutBuilder(
          small: (_, child) => Center(
            child: SizedBox.square(
              dimension: _IconSize.small,
              child: child,
            ),
          ),
          medium: (_, child) => Center(
            key: Key('dashatar_puzzle_icon_container_small_${widget.index}'),
            child: SizedBox.square(
              dimension: _IconSize.medium,
              child: child,
            ),
          ),
          large: (_, child) => Center(
            key: Key('dashatar_puzzle_icon_container_medium_${widget.index}'),
            child: SizedBox.square(
              dimension: _IconSize.large,
              child: child,
            ),
          ),
          child: (_) => FittedBox(
            key: Key('dashatar_puzzle_icon_container_large_${widget.index}'),
            fit: BoxFit.fitWidth,
            child: Icon(
              widget.state.icons[widget.index],
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
