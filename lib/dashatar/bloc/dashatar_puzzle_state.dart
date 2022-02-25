// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

/// The status of [DashatarPuzzleState].
enum DashatarPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started,

  /// The puzzle is stopped
  stopped,
}

enum DashatarPuzzleLevel {
  /// timeout: 60
  easy,

  /// timeout: 45
  medium,

  /// timeout: 30
  hard,
}

class DashatarPuzzleState extends Equatable {
  const DashatarPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
    this.secondsToReset = 45,
    this.isGameCountdownRunning = false,
    this.level = DashatarPuzzleLevel.medium,
  });

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  /// Whether the game countdown is running
  final bool isGameCountdownRunning;

  /// The number of seconds before the puzzle is reset.
  final int secondsToReset;

  /// game level
  final DashatarPuzzleLevel level;

  /// The status of the current puzzle.
  DashatarPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? DashatarPuzzleStatus.loading
      : (secondsToBegin == 0
          ? (isGameCountdownRunning
              ? DashatarPuzzleStatus.started
              : DashatarPuzzleStatus.stopped)
          : DashatarPuzzleStatus.notStarted);

  int get secondsToResetTotal => level == DashatarPuzzleLevel.easy
      ? 60
      : (level == DashatarPuzzleLevel.medium ? 45 : 30);

  @override
  List<Object> get props => [
        isCountdownRunning,
        secondsToBegin,
        isGameCountdownRunning,
        secondsToReset,
        level,
      ];

  DashatarPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
    bool? isGameCountdownRunning,
    int? secondsToReset,
    DashatarPuzzleLevel? level,
  }) {
    return DashatarPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      isGameCountdownRunning:
          isGameCountdownRunning ?? this.isGameCountdownRunning,
      secondsToReset: secondsToReset ?? this.secondsToReset,
      level: level ?? this.level,
    );
  }
}
