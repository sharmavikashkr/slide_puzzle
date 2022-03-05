// ignore_for_file: public_member_api_docs

import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:jam_slide_puzzle/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this._size, {this.random}) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileTapped>(_onTileTapped);
    on<PuzzleReset>(_onPuzzleReset);
  }

  final int _size;

  final Random? random;

  void _onPuzzleInitialized(
    PuzzleInitialized event,
    Emitter<PuzzleState> emit,
  ) {
    final puzzle = _generatePuzzle(_size);
    final icons = _generateIcons(_size);
    emit(
      PuzzleState(puzzle: puzzle.sort(), icons: icons),
    );
  }

  void _onTileTapped(TileTapped event, Emitter<PuzzleState> emit) {
    final tappedTile = event.tile;
    if (state.puzzle.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
      final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
      final puzzleSorted = puzzle.sort();
      var score = state.score;
      for (var i = 0; i < _size; i++) {
        var matched = 0;
        for (var j = 0; j < _size; j++) {
          if (puzzleSorted.tiles[i * _size + j].icon == state.icons[i]) {
            matched++;
          }
        }
        if (matched == _size) {
          for (var j = 0; j < _size; j++) {
            puzzleSorted.tiles[i * _size + j].icon =
                state.icons[Random().nextInt(_size)];
            puzzleSorted.tiles[i * _size + j].flip = true;
          }
          score++;
        }
      }
      emit(
        state.copyWith(
          puzzle: puzzleSorted,
          numberOfMoves: state.numberOfMoves + 1,
          score: score,
        ),
      );
    }
  }

  void _onPuzzleReset(PuzzleReset event, Emitter<PuzzleState> emit) {
    final puzzle = _generatePuzzle(_size, shuffle: true);
    final icons = _generateIcons(_size, shuffle: true);
    emit(
      PuzzleState(
          icons: icons,
          puzzle: puzzle.sort(),
          score: state.score,
          numberOfMoves: state.numberOfMoves),
    );
  }

  /// Build a randomized, solvable puzzle of the given size.
  Puzzle _generatePuzzle(int size, {bool shuffle = false}) {
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile positions.
      currentPositions.shuffle(random);
    }

    final tiles = _getTileListFromPositions(size, currentPositions);

    final puzzle = Puzzle(tiles: tiles);

    return puzzle;
  }

  /// Build a list of tiles - giving each tile their correct position and a
  /// current position.
  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> currentPositions,
  ) {
    if (state.puzzle.tiles.isNotEmpty) {
      final tiles = state.puzzle.tiles;
      return [
        for (int i = 0; i < size * size; i++)
          Tile(
            value: tiles[i].value,
            icon: tiles[i].icon,
            currentPosition: currentPositions[i],
            isWhitespace: tiles[i].isWhitespace,
          )
      ];
    }
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            icon: Icons.abc,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            icon: state.icons[((i - 1) ~/ size)],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  List<IconData> _generateIcons(int size, {bool shuffle = false}) {
    final iconPositions = List<int>.generate(size, (index) => index++);
    if (shuffle) {
      /// shuffle only once
      iconPositions.shuffle(random);
    }
    return [for (int i = 0; i < size; i++) state.icons[iconPositions[i]]];
  }
}
