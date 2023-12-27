import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'dice_animation_state.dart';

class DiceAnimationCubit extends Cubit<DiceAnimationState> {
  DiceAnimationCubit({required this.diceRepo})
      : super(DiceAnimationFinished(frame: diceRepo.last));

  final DiceRepository diceRepo;
  final rng = Random();
  static const animationTime = Duration(milliseconds: 300);

  Future<void> startAnimation(List<int> roll) async {
    var frameCount = 4 + rng.nextInt(4);
    List<List<int>> frames = [await _generateIntermediateRoll(roll)];
    for (int i = 1; i < frameCount; ++i) {
      frames.add(await _generateIntermediateRoll(frames[i - 1]));
    }
    emit(DiceAnimationInProgress(frame: frames.first));
    int i = 1;
    Timer.periodic(animationTime, (timer) async {
      if (i == frameCount) {
        emit(DiceAnimationFinished(frame: roll));
        timer.cancel();
      } else {
        emit(DiceAnimationInProgress(frame: frames[i]));
      }
      ++i;
    });
  }

  void checkRefresh(List<int> dices) {
    if (!listEquals(dices, state.frame)) {
      emit(DiceAnimationFinished(frame: dices));
    }
  }

  Future<List<int>> _generateIntermediateRoll(List<int> target) async {
    List<int> roll = await diceRepo.getNumbers(target.length);
    while (listEquals(roll, target)) {
      roll = await diceRepo.getNumbers(target.length);
    }
    return roll;
  }
}
