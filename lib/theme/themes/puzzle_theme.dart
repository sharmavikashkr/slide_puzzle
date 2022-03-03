import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  /// {@macro puzzle_theme}
  const PuzzleTheme();

  /// The display name of this theme.
  String get name;

  /// The display name of this puzzle.
  String get puzzleName;

  /// The text color of [name].
  Color get nameColor;

  /// The text color of the puzzle title.
  Color get titleColor;

  /// The bottom left background color of this theme.
  Color get backgroundBottomLeftColor;

  /// The top right background color of this theme.
  Color get backgroundTopRightColor;

  /// The default color of this theme.
  ///
  /// Applied to the text color of the score and
  /// the default background color of puzzle tiles.
  Color get defaultColor;

  /// The path to the asset with the unmuted audio control.
  String get audioControlOnAsset;

  /// The path to the asset with the muted audio control.
  String get audioControlOffAsset;

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate;
}
