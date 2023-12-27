part of 'game_cubit.dart';

@immutable
sealed class GameState {
  const GameState(
      {required this.players,
      required this.dices,
      this.message = const [],
      this.round = 0});

  final int players;
  final List<int> dices;
  final List<String> message;
  final int round;

  GameState copyWith({int? players, List<int>? dices});
}

final class RoundEnded extends GameState {
  const RoundEnded(
      {required super.players, required super.dices, required super.round});

  @override
  RoundEnded copyWith({int? players, List<int>? dices, int? round}) {
    return RoundEnded(
        players: players ?? this.players,
        dices: dices ?? this.dices,
        round: round ?? this.round);
  }
}

final class RoundStarted extends GameState {
  const RoundStarted(
      {required super.players,
      required super.dices,
      required super.message,
      super.round = 1});

  @override
  RoundStarted copyWith(
      {int? players, List<int>? dices, List<String>? message, int? round}) {
    return RoundStarted(
        players: players ?? this.players,
        dices: dices ?? this.dices,
        message: message ?? this.message,
        round: round ?? this.round);
  }
}

final class DiceRolling extends GameState {
  const DiceRolling(
      {required this.nextState,
      required super.players,
      required super.dices,
      super.round})
      : super(
            message: nextState is RollingOut || nextState is RolledOut
                ? const ["Pest auswürfeln"]
                : const [" "]);

  DiceRolling.fromState(this.nextState, {required int oldRound})
      : super(
            players: nextState.players,
            dices: nextState.dices,
            round: oldRound,
            message: nextState is RollingOut || nextState is RolledOut
                ? const ["Pest auswürfeln"]
                : const [" "]);

  final GameState nextState;

  @override
  GameState copyWith({int? players, List<int>? dices}) {
    throw UnimplementedError();
  }
}

final class RolledOut extends GameState {
  const RolledOut({required super.players, required super.dices})
      : super(message: const ["Du bist Pest!"]);

  @override
  RolledOut copyWith({int? players, List<int>? dices}) {
    return RolledOut(
        players: players ?? this.players, dices: dices ?? this.dices);
  }
}

final class RollingOut extends GameState {
  const RollingOut({required super.players, required super.dices})
      : super(message: const ["Pest auswürfeln"]);

  @override
  RollingOut copyWith({int? players, List<int>? dices}) {
    return RollingOut(
        players: players ?? this.players, dices: dices ?? this.dices);
  }
}
