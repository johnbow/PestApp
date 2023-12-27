import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.diceRepo})
      : super(const RollingOut(players: 1, dices: [6]));

  final DiceRepository diceRepo;

  void addPlayer() {
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
    if (state.players <= 1) return;
    if (state is RoundStarted) {
      final rs = (state as RoundStarted).copyWith(players: state.players - 1);
      _checkRoundEnded(rs);
    } else {
      emit(state.copyWith(players: state.players - 1));
    }
  }

  void rollDices() async {
    if (state is RollingOut) {
      final roll = await diceRepo.nextNumber();
      if (roll == 3) {
        emit(RolledOut(players: state.players, dices: [roll]));
      } else {
        emit(state.copyWith(dices: [roll]));
      }
    } else if (state is RoundStarted) {
      final roll = await diceRepo.getNumbers(2);
      final message = _doubleRollMessage(roll);
      var rs = (state as RoundStarted).copyWith(dices: roll, message: message);
      if (message.isEmpty) {
        rs = rs.copyWith(message: ["Weitergeben"], round: rs.round + 1);
      }
      _checkRoundEnded(rs);
    }
  }

  void startRound() {
    if (state is! RolledOut) return;
    emit(RoundStarted(
        players: state.players,
        dices: const [6, 6],
        message: const ["Linker Nachbar der Pest fängt an"]));
  }

  void restart() {
    emit(RollingOut(players: state.players, dices: const [1]));
  }

  void _checkRoundEnded(RoundStarted newState) {
    if (newState.round > newState.players) {
      emit(RoundEnded(players: newState.players, dices: newState.dices));
    } else {
      emit(newState);
    }
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

  @override
  void onChange(Change<GameState> change) {
    print("${change.nextState}: ${change.nextState.dices}");
    super.onChange(change);
  }
}
