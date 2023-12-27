part of 'game_cubit.dart';

@immutable
sealed class GameState {
  const GameState(
      {required this.players, required this.dices, this.message = const []});

  final int players;
  final List<int> dices;
  final List<String> message;

  GameState copyWith({int? players, List<int>? dices});
}

final class RoundEnded extends GameState {
  const RoundEnded({required super.players, required super.dices});

  @override
  RoundEnded copyWith({int? players, List<int>? dices}) {
    return RoundEnded(
        players: players ?? this.players, dices: dices ?? this.dices);
  }
}

final class RoundStarted extends GameState {
  const RoundStarted(
      {required super.players,
      required super.dices,
      required super.message,
      this.round = 1});

  final int round;

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
