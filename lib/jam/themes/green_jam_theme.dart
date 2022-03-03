import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';

/// {@template green_jam_theme}
/// The green jam puzzle theme.
/// {@endtemplate}
class GreenJamTheme extends JamTheme {
  /// {@macro green_jam_theme}
  const GreenJamTheme() : super();

  @override
  String get name => 'verde';

  @override
  Color get backgroundBottomLeftColor => Colors.deepPurple;

  @override
  Color get backgroundTopRightColor => Colors.deepOrange;

  @override
  Color get defaultColor => PuzzleColors.green90;

  @override
  Color get countdownColor => PuzzleColors.green50;

  @override
  String get successThemeAsset => 'assets/images/jam/success/green.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/green_jam_off.png';

  @override
  String get audioAsset => 'assets/audio/skateboard.mp3';
}
