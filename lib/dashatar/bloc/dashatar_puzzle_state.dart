// ignore_for_file: public_member_api_docs

part of 'dashatar_puzzle_bloc.dart';

/// The status of [DashatarPuzzleState].
enum DashatarPuzzleStatus {
  /// The puzzle is not started yet.
  notStarted,

  /// The puzzle is loading.
  loading,

  /// The puzzle is started.
  started
}

class DashatarPuzzleState extends Equatable {
  const DashatarPuzzleState(
      {required this.secondsToBegin,
      required this.secondsToReset,
      this.isCountdownRunning = false,
      this.isGameCountdownRunning = false});

  /// Whether the countdown of this puzzle is currently running.
  final bool isCountdownRunning;

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final bool isGameCountdownRunning;

  final int secondsToReset;

  /// The status of the current puzzle.
  DashatarPuzzleStatus get status => isCountdownRunning && secondsToBegin > 0
      ? DashatarPuzzleStatus.loading
      : (secondsToBegin == 0
          ? DashatarPuzzleStatus.started
          : DashatarPuzzleStatus.notStarted);

  @override
  List<Object> get props => [
        isCountdownRunning,
        secondsToBegin,
        isGameCountdownRunning,
        secondsToReset
      ];

  DashatarPuzzleState copyWith({
    bool? isCountdownRunning,
    int? secondsToBegin,
    bool? isGameCountdownRunning,
    int? secondsToReset,
  }) {
    return DashatarPuzzleState(
      isCountdownRunning: isCountdownRunning ?? this.isCountdownRunning,
      secondsToBegin: secondsToBegin ?? this.secondsToBegin,
      isGameCountdownRunning:
          isGameCountdownRunning ?? this.isGameCountdownRunning,
      secondsToReset: secondsToReset ?? this.secondsToReset,
    );
  }
}
