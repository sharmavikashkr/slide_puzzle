import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_slide_puzzle/layout/layout.dart';

import '../../puzzle/bloc/puzzle_bloc.dart';
import '../bloc/dashatar_puzzle_bloc.dart';

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
class DashatarPuzzleIcons extends StatefulWidget {
  /// {@macro dashatar_puzzle_Icon}
  const DashatarPuzzleIcons({
    Key? key,
  }) : super(key: key);

  @override
  State<DashatarPuzzleIcons> createState() => _DashatarPuzzleIconsState();
}

class _DashatarPuzzleIconsState extends State<DashatarPuzzleIcons> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final icons = context.select((PuzzleBloc bloc) => bloc.state.icons);
    final size =
        context.select((PuzzleBloc bloc) => bloc.state.puzzle.getDimension());
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...List.generate(
          size,
          (index) => AnimatedAlign(
            alignment: FractionalOffset(
              0,
              index / (size - 1),
            ),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            child: ResponsiveLayoutBuilder(
              key: ValueKey(Random().nextDouble()),
              small: (_, child) => SizedBox(
                height: _BoxHeight.small,
                width: _BoxWidth.small,
                child: child,
              ),
              medium: (_, child) => SizedBox(
                height: _BoxHeight.medium,
                width: _BoxWidth.medium,
                child: child,
              ),
              large: (_, child) => SizedBox(
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
                  child: SizedBox.square(
                    dimension: _IconSize.medium,
                    child: child,
                  ),
                ),
                large: (_, child) => Center(
                  child: SizedBox.square(
                    dimension: _IconSize.large,
                    child: child,
                  ),
                ),
                child: (_) => FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Icon(
                    icons[index] as IconData,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
