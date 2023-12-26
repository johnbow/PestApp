part of 'game_cubit.dart';

@immutable
sealed class GameState {
  const GameState({required this.players, required this.dices});

  final int players;
  final List<int> dices;

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
      {required super.players, required super.dices, required this.message});

  final List<String> message;

  @override
  RoundStarted copyWith(
      {int? players, List<int>? dices, List<String>? message}) {
    return RoundStarted(
        players: players ?? this.players,
        dices: dices ?? this.dices,
        message: message ?? this.message);
  }
}

final class RolledOut extends GameState {
  const RolledOut({required super.players, required super.dices});

  @override
  RolledOut copyWith({int? players, List<int>? dices}) {
    return RolledOut(
        players: players ?? this.players, dices: dices ?? this.dices);
  }
}

final class RollingOut extends GameState {
  const RollingOut({required super.players, required super.dices});

  @override
  RollingOut copyWith({int? players, List<int>? dices}) {
    return RollingOut(
        players: players ?? this.players, dices: dices ?? this.dices);
  }
}
