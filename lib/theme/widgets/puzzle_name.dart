import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';
import 'package:jam_slide_puzzle/typography/typography.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const PuzzleName({
    Key? key,
    this.color,
  }) : super(key: key);

  /// The color of this name, defaults to [PuzzleTheme.nameColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<JamThemeBloc>().state.theme;
    final nameColor = color ?? theme.nameColor;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(
        child: AnimatedDefaultTextStyle(
          style: PuzzleTextStyle.headline5.copyWith(
            color: nameColor,
          ),
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            theme.puzzleName,
            key: const Key('puzzle_name_theme'),
          ),
        ),
      ),
      medium: (context, child) => Center(
        child: AnimatedDefaultTextStyle(
          style: PuzzleTextStyle.headline5.copyWith(
            color: nameColor,
          ),
          duration: PuzzleThemeAnimationDuration.textStyle,
          child: Text(
            theme.puzzleName,
            key: const Key('puzzle_name_theme'),
          ),
        ),
      ),
      large: (context, child) => AnimatedDefaultTextStyle(
        style: PuzzleTextStyle.headline5.copyWith(
          color: nameColor,
        ),
        duration: PuzzleThemeAnimationDuration.textStyle,
        child: Text(
          theme.puzzleName,
          key: const Key('puzzle_name_theme'),
        ),
      ),
    );
  }
}
