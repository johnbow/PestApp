import 'dart:async';

abstract class DiceRepository {
  DiceRepository({required this.sides});

  final int sides;

  FutureOr<int> nextNumber();

  Future<List<int>> getNumbers(int count) async {
    final numbers = List.filled(count, 0);
    for (int i = 0; i < numbers.length; i++) {
      numbers[i] = await nextNumber();
    }
    return numbers;
  }
}
