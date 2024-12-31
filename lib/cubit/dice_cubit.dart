import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'dice_state.dart';

class DiceCubit extends Cubit<DiceState> {
  DiceCubit({required this.diceRepo})
      : super(DiceInitial(
            roll: diceRepo.firstInitial, message: const ["Pest auswürfeln"]));

  final DiceRepository diceRepo;

  void resetFirst() {
    emit(DiceInitial(
        roll: diceRepo.firstInitial, message: const ["Pest auswürfeln"]));
  }

  void resetSecond() {
    emit(DiceInitial(
        roll: diceRepo.secondInitial,
        message: const ["Linker Nachbar der", "Pest fängt an"]));
  }

  Future<void> rollDice(int num) async {
    if (state is DiceRolling) return;
    final roll = await diceRepo.getNumbers(num);
    emit(DiceRolling(roll: roll));
  }

  void notifyRollFinished() {
    if (state is! DiceRolling) return;
    final message = state.roll.length == 1
        ? ["Pest auswürfeln"]
        : _doubleRollMessage(state.roll);
    emit(DiceRolled(roll: state.roll, message: message));
  }
}

List<String> _doubleRollMessage(List<int> roll) {
  List<String> message = [];

  if (listEquals(roll, [3, 1]) || listEquals(roll, [1, 3])) {
    message.add("Pest muss");
    message.add("EXEN");
    return message;
  }

  if (roll[0] == roll[1]) {
    message.add("Verteile ${roll[0]} ${roll[0] == 1 ? "Schluck" : "Schlücke"}");
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