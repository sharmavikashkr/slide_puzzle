// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

enum TileMovementStatus { nothingTapped, cannotBeMoved, moved }

const _icons = <IconData>[
  Icons.delete_outline_sharp,
  Icons.music_note_sharp,
  Icons.umbrella_sharp,
  Icons.sports_football_sharp
];

class PuzzleState extends Equatable {

  const PuzzleState({
    this.icons = _icons,
    this.puzzle = const Puzzle(tiles: []),
    this.numberOfMoves = 0,
    this.score = 0,
  });

  /// [Puzzle] containing the current list of icons.
  final List icons;

  /// [Puzzle] containing the current tile arrangement.
  final Puzzle puzzle;

  /// Number of moves so far
  final int numberOfMoves;

  /// The current score
  final int score;

  PuzzleState copyWith({
    List? icons,
    Puzzle? puzzle,
    int? numberOfMoves,
    int? score,
  }) {
    return PuzzleState(
      icons: icons ?? this.icons,
      puzzle: puzzle ?? this.puzzle,
      numberOfMoves: numberOfMoves ?? this.numberOfMoves,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [
        icons,
        puzzle,
        numberOfMoves,
        score,
      ];
}
