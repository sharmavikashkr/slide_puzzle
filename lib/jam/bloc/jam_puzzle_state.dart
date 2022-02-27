// ignore_for_file: public_member_api_docs

part of 'jam_puzzle_bloc.dart';

/// The status of [JamPuzzleState].
enum JamPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started,

  /// The puzzle is stopped
  stopped,
}

enum JamPuzzleLevel {
  /// timeout: 60
  easy,

  /// timeout: 45
  medium,

  /// timeout: 30
  hard,
}

class JamPuzzleState extends Equatable {
  const JamPuzzleState({
    required this.secondsToBegin,
    this.isCountdownRunning = false,
    this.secondsToReset = 45,
    this.isGameCountdownRunning = false,
    this.level = JamPuzzleLevel.medium,
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
  final JamPuzzleLevel level;

  /// The status of the current puzzle.
  JamPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? JamPuzzleStatus.loading
      : (secondsToBegin == 0
          ? (isGameCountdownRunning
              ? JamPuzzleStatus.started
              : JamPuzzleStatus.stopped)
          : JamPuzzleStatus.notStarted);

  int get secondsToResetTotal => level == JamPuzzleLevel.easy
      ? 60
      : (level == JamPuzzleLevel.medium ? 45 : 30);

  @override
  List<Object> get props => [
        isCountdownRunning,
        secondsToBegin,
        isGameCountdownRunning,
        secondsToReset,
        level,
      ];

  JamPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
    bool? isGameCountdownRunning,
    int? secondsToReset,
    JamPuzzleLevel? level,
  }) {
    return JamPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      isGameCountdownRunning:
          isGameCountdownRunning ?? this.isGameCountdownRunning,
      secondsToReset: secondsToReset ?? this.secondsToReset,
      level: level ?? this.level,
    );
  }
}
