import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:very_good_slide_puzzle/models/models.dart';

part 'dashatar_puzzle_event.dart';
part 'dashatar_puzzle_state.dart';

/// {@template dashatar_puzzle_bloc}
/// A bloc responsible for starting the Dashatar puzzle.
/// {@endtemplate}
class DashatarPuzzleBloc
    extends Bloc<DashatarPuzzleEvent, DashatarPuzzleState> {
  /// {@macro dashatar_puzzle_bloc}
  DashatarPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
    required Ticker gameTicker,
  })  : _ticker = ticker,
        _gameTicker = gameTicker,
        super(
          DashatarPuzzleState(
            secondsToBegin: secondsToBegin,
          ),
        ) {
    on<DashatarCountdownStarted>(_onCountdownStarted);
    on<DashatarCountdownTicked>(_onCountdownTicked);
    on<DashatarCountdownStopped>(_onCountdownStopped);
    on<DashatarCountdownReset>(_onCountdownReset);

    on<DashatarGameCountdownStarted>(_onGameCountdownStarted);
    on<DashatarGameCountdownTicked>(_onGameCountdownTicked);
    on<DashatarGameCountdownStopped>(_onGameCountdownStopped);

    on<DashatarLevelChanged>(_onDashatarLevelChanged);
  }

  /// The number of seconds before the puzzle is started.
  final int secondsToBegin;

  final Ticker _ticker;

  final Ticker _gameTicker;

  StreamSubscription<int>? _tickerSubscription;

  StreamSubscription<int>? _gameTickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    _gameTickerSubscription?.cancel();
    return super.close();
  }

  void _startTicker(Emitter<DashatarPuzzleState> emit) {
    _tickerSubscription?.cancel();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const DashatarCountdownTicked()));
  }

  void _startGameTicker(Emitter<DashatarPuzzleState> emit) {
    _gameTickerSubscription?.cancel();
    emit(
      state.copyWith(
        isGameCountdownRunning: true,
        secondsToReset: state.secondsToResetTotal,
      ),
    );
    _gameTickerSubscription = _gameTicker
        .tick()
        .listen((_) => add(const DashatarGameCountdownTicked()));
  }

  void _onCountdownStarted(
    DashatarCountdownStarted event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _startTicker(emit);
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownTicked(
    DashatarCountdownTicked event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    if (state.secondsToBegin == 0) {
      _tickerSubscription?.pause();
      emit(
        state.copyWith(
          isCountdownRunning: false,
          secondsToReset: state.secondsToResetTotal,
        ),
      );
      _startGameTicker(emit);
    } else {
      emit(state.copyWith(secondsToBegin: state.secondsToBegin - 1));
    }
  }

  void _onCountdownStopped(
    DashatarCountdownStopped event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _tickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
      ),
    );
  }

  void _onCountdownReset(
    DashatarCountdownReset event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _gameTickerSubscription?.pause();
    _startTicker(emit);
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
        secondsToReset: state.secondsToResetTotal,
        isGameCountdownRunning: false,
      ),
    );
  }

  void _onGameCountdownStarted(
    DashatarGameCountdownStarted event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _startGameTicker(emit);
  }

  void _onGameCountdownTicked(
    DashatarGameCountdownTicked event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    if (state.secondsToReset == 0) {
      _gameTickerSubscription?.pause();
      emit(
        state.copyWith(
          isGameCountdownRunning: false,
          secondsToReset: state.secondsToResetTotal,
        ),
      );
      _startTicker(emit);
    } else {
      emit(state.copyWith(secondsToReset: state.secondsToReset - 1));
    }
  }

  void _onGameCountdownStopped(
    DashatarGameCountdownStopped event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    _gameTickerSubscription?.pause();
    emit(
      state.copyWith(
        isGameCountdownRunning: false,
        secondsToReset: state.secondsToResetTotal,
      ),
    );
  }

  void _onDashatarLevelChanged(
    DashatarLevelChanged event,
    Emitter<DashatarPuzzleState> emit,
  ) {
    emit(state.copyWith(level: event.level));
    _gameTickerSubscription?.pause();
    emit(
      state.copyWith(
        isCountdownRunning: false,
        secondsToBegin: secondsToBegin,
        secondsToReset: state.secondsToResetTotal,
        isGameCountdownRunning: false,
      ),
    );
  }
}
