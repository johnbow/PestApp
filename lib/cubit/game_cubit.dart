import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.diceRepo})
      : super(RollingOut(players: 1, dices: diceRepo.last));

  final DiceRepository diceRepo;

  void addPlayer() {
    if (state is DiceRolling) return;
    if (state is RoundEnded) {
      emit(RoundStarted(
          players: state.players + 1,
          dices: state.dices,
          round: state.players + 1,
          message: const ["Weitergeben"]));
      return;
    }
    emit(state.copyWith(players: state.players + 1));
  }

  void removePlayer() {
    if (state is DiceRolling) return;
    if (state.players <= 1) return;
    if (state is RoundStarted) {
      final rs = (state as RoundStarted).copyWith(players: state.players - 1);
      emit(_checkRoundEnded(rs));
    } else {
      emit(state.copyWith(players: state.players - 1));
    }
  }

  void rollDices() async {
    if (state is RollingOut) {
      final roll = await diceRepo.getNumbers(1);
      if (roll[0] == 3) {
        emit(DiceRolling.fromState(
            RolledOut(players: state.players, dices: roll),
            oldRound: state.round));
      } else {
        emit(DiceRolling.fromState(state.copyWith(dices: roll),
            oldRound: state.round));
      }
    } else if (state is RoundStarted) {
      final roll = await diceRepo.getNumbers(2);
      final message = _doubleRollMessage(roll);
      var rs = (state as RoundStarted).copyWith(dices: roll, message: message);
      if (message.isEmpty) {
        rs = rs.copyWith(message: ["Weitergeben"], round: rs.round + 1);
      }
      emit(DiceRolling.fromState(_checkRoundEnded(rs), oldRound: state.round));
    }
  }

  void startRound() {
    if (state is! RolledOut) return;
    diceRepo.last = const [6, 6];
    emit(RoundStarted(
        players: state.players,
        dices: diceRepo.last,
        message: const ["Linker Nachbar der Pest fängt an"]));
  }

  void onAnimationFinished() {
    if (state is! DiceRolling) return;
    emit((state as DiceRolling).nextState);
  }

  void restart() {
    if (state is DiceRolling) return;
    diceRepo.last = const [1];
    emit(RollingOut(players: state.players, dices: diceRepo.last));
  }

  GameState _checkRoundEnded(RoundStarted newState) {
    return newState.round > newState.players
        ? RoundEnded(
            players: newState.players,
            dices: newState.dices,
            round: newState.round)
        : newState;
  }

  List<String> _doubleRollMessage(List<int> roll) {
    List<String> message = [];

    if (listEquals(roll, [3, 1]) || listEquals(roll, [1, 3])) {
      message.add("Pest muss exen!");
      return message;
    }

    if (roll[0] == roll[1]) {
      message
          .add("Verteile ${roll[0]} ${roll[0] == 1 ? "Schluck" : "Schlücke"}");
    }

    final eyesum = roll[0] + roll[1];
    switch (eyesum) {
      case 3:
        message.add("Pest muss trinken!");
      case 7:
        message.add("Alle an die Nase fassen!");
      case 8:
        message.add("Linker Nachbar trinkt!");
      case 9:
        message.add("Rechter Nachbar trinkt!");
    }

    if (roll[0] == 3 && roll[1] == 3) {
      message.add("Pest muss doppelt trinken!");
    } else if (roll[0] == 3 || roll[1] == 3) {
      message.add("Pest muss trinken!");
    }

    return message;
  }
}
