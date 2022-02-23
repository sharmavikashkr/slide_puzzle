// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.numberOfMoves = 0,
    this.score = 0,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Number of moves so far
  final int numberOfMoves;

  /// The current score
  final int score;

  PuzzleState copyWith({
    Puzzle? puzzle,
    int? numberOfMoves,
    int? score,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        numberOfMoves,
        score,
      ];
}
