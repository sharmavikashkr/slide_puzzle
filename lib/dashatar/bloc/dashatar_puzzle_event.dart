// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

abstract class DashatarPuzzleEvent extends Equatable {
  const DashatarPuzzleEvent();

  @override
  List<Object?> get props => [];
}

class DashatarCountdownStarted extends DashatarPuzzleEvent {
  const DashatarCountdownStarted();
}

class DashatarCountdownTicked extends DashatarPuzzleEvent {
  const DashatarCountdownTicked();
}

class DashatarCountdownStopped extends DashatarPuzzleEvent {
  const DashatarCountdownStopped();
}

class DashatarCountdownReset extends DashatarPuzzleEvent {
  const DashatarCountdownReset();
}

class DashatarGameCountdownStarted extends DashatarPuzzleEvent {
  const DashatarGameCountdownStarted();
}

class DashatarGameCountdownTicked extends DashatarPuzzleEvent {
  const DashatarGameCountdownTicked();
}

class DashatarGameCountdownStopped extends DashatarPuzzleEvent {
  const DashatarGameCountdownStopped();
}

class DashatarGameCountdownReset extends DashatarPuzzleEvent {
  const DashatarGameCountdownReset();
}

class DashatarLevelChanged extends DashatarPuzzleEvent {
  const DashatarLevelChanged({required this.level});

  /// The index of the changed theme in [DashatarThemeState.themes].
  final DashatarPuzzleLevel level;

  @override
  List<Object> get props => [level];
}
