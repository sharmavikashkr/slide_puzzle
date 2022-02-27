// ignore_for_file: public_member_api_docs

part of 'jam_theme_bloc.dart';

abstract class JamThemeEvent extends Equatable {
  const JamThemeEvent();
}

class JamThemeChanged extends JamThemeEvent {
  const JamThemeChanged({required this.themeIndex});

  /// The index of the changed theme in [JamThemeState.themes].
  final int themeIndex;

  @override
  List<Object> get props => [themeIndex];
}
