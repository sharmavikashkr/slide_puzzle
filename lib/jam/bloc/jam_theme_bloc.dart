import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jam_slide_puzzle/jam/jam.dart';

part 'jam_theme_event.dart';
part 'jam_theme_state.dart';

/// {@template jam_theme_bloc}
/// Bloc responsible for the currently selected [JamTheme].
/// {@endtemplate}
class JamThemeBloc extends Bloc<JamThemeEvent, JamThemeState> {
  /// {@macro jam_theme_bloc}
  JamThemeBloc({required List<JamTheme> themes})
      : super(JamThemeState(themes: themes)) {
    on<JamThemeChanged>(_onJamThemeChanged);
  }

  void _onJamThemeChanged(
    JamThemeChanged event,
    Emitter<JamThemeState> emit,
  ) {
    emit(state.copyWith(theme: state.themes[event.themeIndex]));
  }
}
