import 'dart:async';
import 'dart:math';

import 'package:pest/repositories/dice_repository.dart';

class RandomDice extends DiceRepository {
  RandomDice({required super.sides, required super.initial});

  final rng = Random();

  @override
  FutureOr<int> get nextNumber {
    return 1 + rng.nextInt(sides);
  }
}
