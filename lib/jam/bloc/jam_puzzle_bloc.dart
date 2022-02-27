import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jam_slide_puzzle/models/models.dart';

part 'jam_puzzle_event.dart';
part 'jam_puzzle_state.dart';

/// {@template jam_puzzle_bloc}
/// A bloc responsible for starting the Jam puzzle.
/// {@endtemplate}
class JamPuzzleBloc extends Bloc<JamPuzzleEvent, JamPuzzleState> {
  /// {@macro jam_puzzle_bloc}
  JamPuzzleBloc({
    required this.secondsToBegin,
    required Ticker ticker,
    required Ticker gameTicker,
  })  : _ticker = ticker,
        _gameTicker = gameTicker,
        super(
          JamPuzzleState(
            secondsToBegin: secondsToBegin,
          ),
        ) {
    on<JamCountdownStarted>(_onCountdownStarted);
    on<JamCountdownTicked>(_onCountdownTicked);
    on<JamCountdownStopped>(_onCountdownStopped);
    on<JamCountdownReset>(_onCountdownReset);

    on<JamGameCountdownStarted>(_onGameCountdownStarted);
    on<JamGameCountdownTicked>(_onGameCountdownTicked);
    on<JamGameCountdownStopped>(_onGameCountdownStopped);

    on<JamLevelChanged>(_onJamLevelChanged);
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

  void _startTicker(Emitter<JamPuzzleState> emit) {
    _tickerSubscription?.cancel();
    emit(
      state.copyWith(
        isCountdownRunning: true,
        secondsToBegin: secondsToBegin,
      ),
    );
    _tickerSubscription =
        _ticker.tick().listen((_) => add(const JamCountdownTicked()));
  }

  void _startGameTicker(Emitter<JamPuzzleState> emit) {
    _gameTickerSubscription?.cancel();
    emit(
      state.copyWith(
        isGameCountdownRunning: true,
        secondsToReset: state.secondsToResetTotal,
      ),
    );
    _gameTickerSubscription =
        _gameTicker.tick().listen((_) => add(const JamGameCountdownTicked()));
  }

  void _onCountdownStarted(
    JamCountdownStarted event,
    Emitter<JamPuzzleState> emit,
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
    JamCountdownTicked event,
    Emitter<JamPuzzleState> emit,
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
    JamCountdownStopped event,
    Emitter<JamPuzzleState> emit,
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
    JamCountdownReset event,
    Emitter<JamPuzzleState> emit,
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
    JamGameCountdownStarted event,
    Emitter<JamPuzzleState> emit,
  ) {
    _startGameTicker(emit);
  }

  void _onGameCountdownTicked(
    JamGameCountdownTicked event,
    Emitter<JamPuzzleState> emit,
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
    JamGameCountdownStopped event,
    Emitter<JamPuzzleState> emit,
  ) {
    _gameTickerSubscription?.pause();
    emit(
      state.copyWith(
        isGameCountdownRunning: false,
        secondsToReset: state.secondsToResetTotal,
      ),
    );
  }

  void _onJamLevelChanged(
    JamLevelChanged event,
    Emitter<JamPuzzleState> emit,
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
