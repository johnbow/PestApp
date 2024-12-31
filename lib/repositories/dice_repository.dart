import 'dart:async';

abstract class DiceRepository {
  DiceRepository(
      {required this.sides,
      required this.firstInitial,
      required this.secondInitial});

  final int sides;
  final List<int> firstInitial;
  final List<int> secondInitial;

  FutureOr<int> get nextNumber;

  Future<List<int>> getNumbers(int count) async {
    final numbers = List.filled(count, 0);
    for (int i = 0; i < numbers.length; i++) {
      numbers[i] = await nextNumber;
    }
    return numbers;
  }
}
