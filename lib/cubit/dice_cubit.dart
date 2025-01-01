import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';
import 'package:pest/repositories/settings_repository.dart';

part 'dice_state.dart';

class DiceCubit extends Cubit<DiceState> {
  DiceCubit({required this.diceRepo, required this.settings})
      : super(DiceInitial(
            roll: diceRepo.firstInitial, message: const ["Pest auswürfeln"]));

  final DiceRepository diceRepo;
  final Settings settings;

  void resetFirst() {
    emit(DiceInitial(
        roll: diceRepo.firstInitial,
        message: const ["Linker Nachbar der", "Pest fängt an"]));
  }

  void resetSecond() {
    emit(DiceInitial(
        roll: diceRepo.secondInitial,
        message: const ["Linker Nachbar der", "Pest fängt an"]));
  }

  Future<void> rollDice(int num, int round) async {
    if (state is DiceRolling) return;
    List<int> roll = await diceRepo.getNumbers(num);
    while (num == 1 && roll[0] == 3 && _checkNoConsecutivePest(round)) {
      roll = await diceRepo.getNumbers(num);
    }
    emit(DiceRolling(roll: roll));
  }

  void notifyRollFinished() {
    if (state is! DiceRolling) return;
    final message = state.roll.length == 1
        ? ["Pest auswürfeln"]
        : (settings.bigGroupSetting
            ? _doubleRollMessageBigGroup(state.roll)
            : _doubleRollMessage(state.roll));
    emit(DiceRolled(roll: state.roll, message: message));
  }

  /// Returns true if current player cant be Pest.
  bool _checkNoConsecutivePest(int round) {
    return settings.noConsecutivePest &&
        settings.lastPest != null &&
        settings.lastPest == round;
  }

  List<String> _doubleRollMessage(List<int> roll) {
    List<String> message = [];

    if (listEquals(roll, [3, 1]) || listEquals(roll, [1, 3])) {
      message.add("Pest muss");
      message.add("EXEN");
      return message;
    }

    if (roll[0] == roll[1]) {
      message
          .add("Verteile ${roll[0]} ${roll[0] == 1 ? "Schluck" : "Schlücke"}");
    }

    switch (roll[0] + roll[1]) {
      case 3:
        message.add("Pest muss trinken!");
      case 7:
        message.add("Alle an die Nase fassen!");
        message.add("Letzter trinkt einen Schluck");
      case 8:
        message.add("Linker Nachbar trinkt");
      case 9:
        message.add("Rechter Nachbar trinkt");
    }

    if (roll[0] == 3 && roll[1] == 3) {
      message.add("Pest muss doppelt trinken!");
    } else if (roll[0] == 3 || roll[1] == 3) {
      message.add("Pest muss trinken!");
    }

    final pass = switch (settings.passingBehavior) {
      PassingBehavior.afterPestDoesNotDrink =>
        !(roll.contains(3) || roll[0] + roll[1] == 3),
      PassingBehavior.afterNoDrinking => message.isEmpty,
      _ => true
    };

    if (pass) message.add("Weitergeben");

    return message;
  }

  List<String> _doubleRollMessageBigGroup(List<int> roll) {
    List<String> message = [];

    if (listEquals(roll, [3, 1]) || listEquals(roll, [1, 3])) {
      message.add("Pest trinkt 7 Schlücke!");
      return message;
    }

    if (listEquals(roll, [1, 1])) {
      message.add("Alle trinken einen Schluck!");
    } else if (roll[0] == roll[1]) {
      message.add("Verteile ${2 * roll[0]} Schlücke");
    }

    switch (roll[0] + roll[1]) {
      case 3:
        message.add("Pest muss trinken!");
      case 7:
        message.add("Alle an die Nase fassen!");
        message.add("Letzter trinkt 3 Schlücke");
      case 8:
        message.add("Linker Nachbar trinkt");
      case 9:
        message.add("Rechter Nachbar trinkt");
    }

    if (roll[0] == 3 && roll[1] == 3) {
      message.add("Pest muss doppelt trinken!");
    } else if (roll[0] == 3 || roll[1] == 3) {
      message.add("Pest muss trinken!");
    }

    final pass = switch (settings.passingBehavior) {
      PassingBehavior.afterPestDoesNotDrink =>
        !(roll.contains(3) || roll[0] + roll[1] == 3),
      PassingBehavior.afterNoDrinking => message.isEmpty,
      _ => true
    };

    if (message.isEmpty) message.add("Trink selbst 5 Schlücke!");

    if (pass) message.add("Weitergeben");

    return message;
  }
}
