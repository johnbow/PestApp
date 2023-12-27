import 'dart:async';

abstract class DiceRepository {
  DiceRepository({required this.sides, required List<int> initial})
      : last = initial;

  final int sides;

  List<int> last;

  FutureOr<int> get nextNumber;

  Future<List<int>> getNumbers(int count) async {
    final numbers = List.filled(count, 0);
    for (int i = 0; i < numbers.length; i++) {
      numbers[i] = await nextNumber;
    }
    last = numbers;
    return numbers;
  }
}
