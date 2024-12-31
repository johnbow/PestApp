import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const FirstStage(players: 1));

  static const unoccupiedList = [
    [4, 1],
    [1, 4],
    [4, 2],
    [2, 4],
    [5, 1],
    [1, 5],
    [6, 4],
    [4, 6],
    [6, 5],
    [5, 6]
  ];

  void addPlayer() {
    emit(state.copyWith(players: state.players + 1));
  }

  void removePlayer() {
    if (state.players <= 1) return;
    final newRound = max(1, state.round - 1);
    emit(state.copyWith(players: state.players - 1, round: newRound));
  }

  void restart() {
    emit(FirstStage(players: state.players, round: 1));
  }

  /// Checks if double dice roll fits criteria for next player to play.
  bool _nextPlayersTurn(List<int> roll) {
    for (final entry in unoccupiedList) {
      if (listEquals(entry, roll)) return true;
    }
    return false;
  }

  int _nextRound() {
    return state.round % state.players + 1;
  }

  void notifyRollFinished(List<int> roll) {
    if (state is FirstStage) {
      if (roll[0] == 3) {
        nextStage();
      } else {
        emit(state.copyWith(round: _nextRound()));
      }
    } else if (state is SecondStage && _nextPlayersTurn(roll)) {
      if (state.players == state.round) {
        nextStage();
      } else {
        emit(state.copyWith(round: state.round + 1));
      }
    }
  }

  void nextStage() {
    switch (state) {
      case FirstStage():
        emit(FirstStageEnded(players: state.players, round: state.round));
        break;
      case FirstStageEnded():
        emit(SecondStage(players: state.players, round: 1));
        break;
      case SecondStage():
        emit(SecondStageEnded(players: state.players));
        break;
      case SecondStageEnded():
        restart();
        break;
    }
  }
}
