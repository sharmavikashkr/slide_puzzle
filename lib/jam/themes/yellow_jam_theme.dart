import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';

/// {@template yellow_jam_theme}
/// The yellow jam puzzle theme.
/// {@endtemplate}
class YellowJamTheme extends JamTheme {
  /// {@macro yellow_jam_theme}
  const YellowJamTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.jamYellowDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.yellowPrimary;

  @override
  Color get defaultColor => PuzzleColors.yellow90;

  @override
  Color get buttonColor => PuzzleColors.yellow50;

  @override
  Color get menuInactiveColor => PuzzleColors.yellow50;

  @override
  Color get countdownColor => PuzzleColors.yellow50;

  @override
  String get themeAsset => 'assets/images/jam/gallery/yellow.png';

  @override
  String get successThemeAsset => 'assets/images/jam/success/yellow.png';

  @override
  String get audioControlOffAsset =>
      'assets/images/audio_control/yellow_jam_off.png';

  @override
  String get audioAsset => 'assets/audio/sandwich.mp3';
}
