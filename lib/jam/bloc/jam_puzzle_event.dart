// ignore_for_file: public_member_api_docs

part of 'jam_puzzle_bloc.dart';

abstract class JamPuzzleEvent extends Equatable {
  const JamPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class JamCountdownStarted extends JamPuzzleEvent {
  const JamCountdownStarted();
}

class JamCountdownTicked extends JamPuzzleEvent {
  const JamCountdownTicked();
}

class JamCountdownStopped extends JamPuzzleEvent {
  const JamCountdownStopped();
}

class JamCountdownReset extends JamPuzzleEvent {
  const JamCountdownReset();
}

class JamGameCountdownStarted extends JamPuzzleEvent {
  const JamGameCountdownStarted();
}

class JamGameCountdownTicked extends JamPuzzleEvent {
  const JamGameCountdownTicked();
}

class JamGameCountdownStopped extends JamPuzzleEvent {
  const JamGameCountdownStopped();
}

class JamGameCountdownReset extends JamPuzzleEvent {
  const JamGameCountdownReset();
}

class JamLevelChanged extends JamPuzzleEvent {
  const JamLevelChanged({required this.level});

  /// The index of the changed theme in [JamThemeState.themes].
  final JamPuzzleLevel level;

  @override
  List<Object> get props => [level];
}
