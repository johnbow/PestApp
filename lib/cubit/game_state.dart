part of 'game_cubit.dart';

@immutable
sealed class GameState {
  const GameState(
      {required this.players, required this.numDice, this.round = 1});

  final int players;
  final int numDice;
  final int round;

  GameState copyWith({int? players, int? round});
}

class FirstStage extends GameState {
  const FirstStage({required super.players}) : super(numDice: 1);

  @override
  FirstStage copyWith({int? players, int? round}) {
    return FirstStage(players: players ?? this.players);
  }
}

class FirstStageEnded extends GameState {
  const FirstStageEnded({required super.players}) : super(numDice: 1);

  @override
  FirstStageEnded copyWith({int? players, int? round}) {
    return FirstStageEnded(players: players ?? this.players);
  }
}

class SecondStage extends GameState {
  const SecondStage({required super.players, super.round}) : super(numDice: 2);

  @override
  SecondStage copyWith({int? players, int? round}) {
    return SecondStage(
        players: players ?? this.players, round: round ?? this.round);
  }
}

class SecondStageEnded extends GameState {
  const SecondStageEnded({required super.players})
      : super(numDice: 2, round: players);

  @override
  SecondStageEnded copyWith({int? players, int? round}) {
    return SecondStageEnded(players: players ?? this.players);
  }
}
