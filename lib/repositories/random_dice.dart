import 'dart:async';
import 'dart:math';

import 'package:pest/repositories/dice_repository.dart';

class RandomDice extends DiceRepository {
  RandomDice({required super.sides});

  final rng = Random();

  @override
  FutureOr<int> nextNumber() {
    return 1 + rng.nextInt(sides);
  }
}
