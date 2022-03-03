import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';

/// {@template blue_jam_theme}
/// The blue jam puzzle theme.
/// {@endtemplate}
class BlueJamTheme extends JamTheme {
  /// {@macro blue_jam_theme}
  const BlueJamTheme() : super();

  @override
  String get name => 'azul';

  @override
  Color get backgroundBottomLeftColor => Colors.brown;

  @override
  Color get backgroundTopRightColor => Colors.green;

  @override
  Color get defaultColor => PuzzleColors.blue90;

  @override
  Color get countdownColor => PuzzleColors.blue50;

  @override
  String get successThemeAsset => 'assets/images/jam/success/blue.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/blue_jam_off.png';

  @override
  String get audioAsset => 'assets/audio/dumbbell.mp3';
}
