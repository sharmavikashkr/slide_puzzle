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
  const DashatarCountdownReset({this.secondsToBegin});
  
  final int? secondsToBegin;

  @override
  List<Object?> get props => [secondsToBegin];
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
  const DashatarGameCountdownReset({this.secondsToReset});

  final int? secondsToReset;

  @override
  List<Object?> get props => [secondsToReset];
}
