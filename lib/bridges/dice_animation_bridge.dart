import 'dart:async';

import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/utils/bloc_bridge.dart';

class DiceAnimationBridge extends BlocBridge<DiceCubit, DiceState,
    DiceAnimationCubit, DiceAnimationState> {
  @override
  FutureOr<void> onChangeFromA(DiceAnimationCubit other, DiceState newState) {
    if (newState is DiceRolling) other.startAnimation(newState.roll);
  }

  @override
  FutureOr<void> onChangeFromB(DiceCubit other, DiceAnimationState newState) {
    if (newState is DiceAnimationFinished) other.notifyRollFinished();
  }
}
