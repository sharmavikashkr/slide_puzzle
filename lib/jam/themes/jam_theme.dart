import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/layout/layout.dart';
import 'package:jam_slide_puzzle/theme/theme.dart';

/// {@template jam_theme}
/// The jam puzzle theme.
/// {@endtemplate}
abstract class JamTheme extends PuzzleTheme {
  /// {@macro jam_theme}
  const JamTheme() : super();

  @override
  String get puzzleName => 'Just Another Monday';

  @override
  String get audioControlOnAsset => 'assets/images/audio_control/jam_on.png';

  @override
  Color get nameColor => PuzzleColors.white;

  @override
  Color get titleColor => PuzzleColors.white;

  @override
  PuzzleLayoutDelegate get layoutDelegate => const JamPuzzleLayoutDelegate();

  /// The text color of the countdown timer.
  Color get countdownColor;

  /// The path to the success image asset of this theme.
  ///
  /// This asset is shown in the success state of the Jam puzzle.
  String get successThemeAsset;

  /// The path to the audio asset of this theme.
  String get audioAsset;

  @override
  List<Object?> get props => [
        name,
        nameColor,
        titleColor,
        defaultColor,
        audioControlOnAsset,
        audioControlOffAsset,
        layoutDelegate,
        countdownColor,
        successThemeAsset,
        audioAsset
      ];
}
