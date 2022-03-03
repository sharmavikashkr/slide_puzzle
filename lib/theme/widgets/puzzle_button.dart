import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';
import 'package:jam_slide_puzzle/typography/typography.dart';

/// {@template puzzle_button}
/// Displays the puzzle action button.
/// {@endtemplate}
class PuzzleButton extends StatelessWidget {
  /// {@macro puzzle_button}
  const PuzzleButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  /// Called when this button is tapped.
  final VoidCallback? onPressed;

  /// The label of this button.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = context.read<JamThemeBloc>().state.theme;

    return SizedBox(
      width: 120,
      height: 44,
      child: AnimatedTextButton(
        duration: PuzzleThemeAnimationDuration.textStyle,
        style: TextButton.styleFrom(
          elevation: 20,
          padding: EdgeInsets.zero,
          textStyle: PuzzleTextStyle.label,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ).copyWith(
          backgroundColor: MaterialStateProperty.all(theme.defaultColor),
          foregroundColor: MaterialStateProperty.all(PuzzleColors.black),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
