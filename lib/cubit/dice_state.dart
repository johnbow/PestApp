part of 'dice_cubit.dart';

@immutable
sealed class DiceState extends Equatable {
  const DiceState({required this.roll});

  final List<int> roll;

  @override
  List<Object> get props => [roll];
}

final class DiceInitial extends DiceState {
  const DiceInitial({required super.roll, required this.message});

  final List<String> message;
}

final class DiceRolled extends DiceState {
  const DiceRolled({required super.roll, required this.message});

  final List<String> message;
}

final class DiceRolling extends DiceState {
  const DiceRolling({required super.roll});
}
