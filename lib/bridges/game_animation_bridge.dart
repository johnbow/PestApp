import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/utils/bloc_bridge.dart';

class GameAnimationBridge extends BlocBridge<GameCubit, GameState,
    DiceAnimationCubit, DiceAnimationState> {
  @override
  bool changeWhenA(GameState prev, GameState curr) {
    return prev.runtimeType != curr.runtimeType;
  }

  @override
  void onChangeFromA(DiceAnimationCubit other, GameState newState) {
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
  void onChangeFromB(GameCubit other, DiceAnimationState newState) {}
}
