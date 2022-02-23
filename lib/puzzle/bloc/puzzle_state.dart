// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

class PuzzleState extends Equatable {
  const PuzzleState({
    this.puzzle = const Puzzle(tiles: []),
    this.tileMovementStatus = TileMovementStatus.nothingTapped,
    this.numberOfMoves = 0,
    this.lastTappedTile,
    this.score = 0,
  });

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Status indicating if a [Tile] was moved or why a [Tile] was not moved.
  final TileMovementStatus tileMovementStatus;

  /// Represents the last tapped tile of the puzzle.
  ///
  /// The value is `null` if the user has not interacted with
  /// the puzzle yet.
  final Tile? lastTappedTile;

  /// Number representing how many moves have been made on the current puzzle.
  ///
  /// The number of moves is not always the same as the total number of tiles
  /// moved. If a row/column of 2+ tiles are moved from one tap, one move is
  /// added.
  final int numberOfMoves;

  /// The current score
  final int score;

  PuzzleState copyWith({
    Puzzle? puzzle,
    TileMovementStatus? tileMovementStatus,
    int? numberOfMoves,
    Tile? lastTappedTile,
    int? score,
  }) {
    return PuzzleState(
      puzzle: puzzle ?? this.puzzle,
      tileMovementStatus: tileMovementStatus ?? this.tileMovementStatus,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      lastTappedTile: lastTappedTile ?? this.lastTappedTile,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [
        puzzle,
        tileMovementStatus,
        numberOfMoves,
        lastTappedTile,
        score,
      ];
}
