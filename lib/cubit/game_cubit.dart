import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/settings_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this.settings) : super(const FirstStage(players: 1));

  final Settings settings;

  void addPlayer() {
    if (settings.lastPest != null) {
      settings.lastPest = settings.lastPest! + 1;
    }
    emit(state.copyWith(players: state.players + 1));
  }

  void removePlayer() {
    if (state.players <= 1) return;
    if (settings.lastPest != null) {
      settings.lastPest = settings.lastPest! - 1;
    }
    final newRound = max(1, state.round - 1);
    emit(state.copyWith(players: state.players - 1, round: newRound));
  }

  void restart() {
    settings.lastPest = null;
    emit(FirstStage(players: state.players, round: 1));
  }

  /// Checks if double dice roll fits criteria for next player to play.
  bool _nextPlayersTurn(List<int> roll) {
    switch (settings.passingBehavior) {
      case PassingBehavior.afterPestDoesNotDrink:
        return !(roll.contains(3) || roll[0] + roll[1] == 3);
      case PassingBehavior.afterNoDrinking:
        for (final entry in noDrinkingRolls) {
          if (listEquals(entry, roll)) return true;
        }
        return false;
      default:
        return true; // includes PassingBehavior.immediate
    }
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
        settings.lastPest = state.players;
        emit(FirstStage(players: state.players, round: 1));
        break;
    }
  }
}

const noDrinkingRolls = [
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
