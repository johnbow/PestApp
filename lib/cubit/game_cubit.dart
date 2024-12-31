import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.diceRepo}) : super(const FirstStage(players: 1));

  final DiceRepository diceRepo;

  void addPlayer() {
    emit(state.copyWith(players: state.players + 1));
  }

  void removePlayer() {
    if (state.players <= 1) return;
    final newRound = max(1, state.round - 1);
    emit(state.copyWith(players: state.players - 1, round: newRound));
  }

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

  void restart() {
    emit(FirstStage(players: state.players));
  }

  /// Checks if double dice roll fits criteria for next player to play.
  bool _nextPlayersTurn(List<int> roll) {
    for (final entry in unoccupiedList) {
      if (listEquals(entry, roll)) return true;
    }
    return false;
  }

  void notifyRollFinished(List<int> roll) {
    if (state is FirstStage && roll[0] == 3) {
      nextStage();
    } else if (state is SecondStage && _nextPlayersTurn(roll)) {
      if (state.players == state.round) {
        nextStage();
      } else {
        emit(SecondStage(players: state.players, round: state.round + 1));
      }
    }
  }

  void nextStage() {
    switch (state) {
      case FirstStage():
        emit(FirstStageEnded(players: state.players));
        break;
      case FirstStageEnded():
        emit(SecondStage(players: state.players));
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
