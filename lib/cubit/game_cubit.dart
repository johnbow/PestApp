import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required this.diceRepo})
      : super(const RollingOut(players: 1, dices: [6]));

  final DiceRepository diceRepo;

  void addPlayer() => emit(state.copyWith(players: state.players + 1));

  void removePlayer() {
    if (state.players <= 1) return;
    emit(state.copyWith(players: state.players - 1));
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
      emit((state as RoundStarted).copyWith(dices: roll, message: message));
    }
  }

  void startRound() {
    if (state is! RolledOut) return;
    emit(RoundStarted(
        players: state.players,
        dices: const [6, 6],
        message: const ["Linker Nachbar der Pest fängt an"]));
  }

  List<String> _doubleRollMessage(List<int> roll) {
    List<String> message = [];

    if (roll == [3, 1] || roll == [1, 3]) {
      message.add("Pest muss exen!");
      return message;
    }

    if (roll[0] == roll[1]) {
      message.add("Verteile ${roll[0]} Schlücke!");
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

    if (message.isEmpty) {
      message.add("Weitergeben");
    }

    return message;
  }
}
