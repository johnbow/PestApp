part of 'game_cubit.dart';

@immutable
sealed class GameState {
  const GameState({required this.players, this.round = 1});

  final int players;
  final int round;

  int get numDice;

  GameState copyWith({int? players, int? round});
}

class FirstStage extends GameState {
  const FirstStage({required super.players, super.round});

  @override
  int get numDice => 1;

  @override
  FirstStage copyWith({int? players, int? round}) {
    return FirstStage(
        players: players ?? this.players, round: round ?? this.round);
  }
}

class FirstStageEnded extends GameState {
  const FirstStageEnded({required super.players, super.round});

  @override
  int get numDice => 1;

  @override
  FirstStageEnded copyWith({int? players, int? round}) {
    return FirstStageEnded(
        players: players ?? this.players, round: round ?? this.round);
  }
}

class SecondStage extends GameState {
  const SecondStage({required super.players, super.round});

  @override
  int get numDice => 2;

  @override
  SecondStage copyWith({int? players, int? round}) {
    return SecondStage(
        players: players ?? this.players, round: round ?? this.round);
  }
}

class SecondStageEnded extends GameState {
  const SecondStageEnded({required super.players}) : super(round: players);

  @override
  int get numDice => 2;

  @override
  SecondStageEnded copyWith({int? players, int? round}) {
    return SecondStageEnded(players: players ?? this.players);
  }
}
