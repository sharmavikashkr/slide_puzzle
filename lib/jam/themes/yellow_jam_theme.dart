import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';

/// {@template yellow_jam_theme}
/// The yellow jam puzzle theme.
/// {@endtemplate}
class YellowJamTheme extends JamTheme {
  /// {@macro yellow_jam_theme}
  const YellowJamTheme() : super();

  @override
  String get name => 'amarilla';

  @override
  Color get backgroundBottomLeftColor => Colors.red;

  @override
  Color get backgroundTopRightColor => Colors.blue;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  String get successThemeAsset => 'assets/images/jam/success/yellow.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_jam_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';
}
