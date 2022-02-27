import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/colors/colors.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';
import 'package:jam_slide_puzzle/l10n/l10n.dart';

/// {@template green_jam_theme}
/// The green jam puzzle theme.
/// {@endtemplate}
class GreenJamTheme extends JamTheme {
  /// {@macro green_jam_theme}
  const GreenJamTheme() : super();

  @override
  String semanticsLabel(BuildContext context) =>
      context.l10n.jamGreenDashLabelText;

  @override
  Color get backgroundColor => PuzzleColors.greenPrimary;

  @override
  Color get defaultColor => PuzzleColors.green90;

  @override
  Color get buttonColor => PuzzleColors.green50;

  @override
  Color get menuInactiveColor => PuzzleColors.green50;

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
