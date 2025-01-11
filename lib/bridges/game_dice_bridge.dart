import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/utils/bloc_bridge.dart';

class GameDiceBridge
    extends BlocBridge<GameCubit, GameState, DiceCubit, DiceState> {
  @override
  bool changeWhenA(GameState prev, GameState curr) {
    return prev.runtimeType != curr.runtimeType;
  }

  @override
  void onChangeFromA(DiceCubit other, GameState newState) {
    switch (newState) {
      case FirstStage():
        other.resetFirst();
      case SecondStage():
        other.resetSecond();
      default:
        break;
    }
  }

  @override
  void onChangeFromB(GameCubit other, DiceState newState) {
    if (newState is DiceRolled) other.notifyRollFinished(newState.roll);
  }
}
