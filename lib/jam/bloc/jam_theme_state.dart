// ignore_for_file: public_member_api_docs

part of 'jam_theme_bloc.dart';

class JamThemeState extends Equatable {
  const JamThemeState({
    required this.themes,
    this.theme = const GreenJamTheme(),
  });

  /// The list of all available [JamTheme]s.
  final List<JamTheme> themes;

  /// Currently selected [JamTheme].
  final JamTheme theme;

  @override
  List<Object> get props => [themes, theme];

  JamThemeState copyWith({
    List<JamTheme>? themes,
    JamTheme? theme,
  }) {
    return JamThemeState(
      themes: themes ?? this.themes,
      theme: theme ?? this.theme,
    );
  }
}
