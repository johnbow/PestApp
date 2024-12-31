import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:pest/repositories/dice_repository.dart';

part 'dice_animation_state.dart';

class DiceAnimationCubit extends Cubit<DiceAnimationState> {
  DiceAnimationCubit({required this.diceRepo})
      : super(DiceAnimationFinished(frame: diceRepo.firstInitial));

  final DiceRepository diceRepo;
  final rng = Random();
  static const animationFrameDuration = Duration(milliseconds: 300);
  static const animationFramesRange = [4, 8]; // inclusive, inclusive

  void resetFirst() {
    emit(DiceAnimationFinished(frame: diceRepo.firstInitial));
  }

  void resetSecond() {
    emit(DiceAnimationFinished(frame: diceRepo.secondInitial));
  }

  Future<void> startAnimation(List<int> roll) async {
    final diff = animationFramesRange[1] - animationFramesRange[0];
    final frameCount = animationFramesRange[0] + rng.nextInt(diff);
    final frames = [await _generateIntermediateRoll(roll)];
    for (int i = 1; i < frameCount; ++i) {
      frames.add(await _generateIntermediateRoll(frames[i - 1]));
    }
    emit(DiceAnimationInProgress(frame: frames.first));
    int i = 1;
    Timer.periodic(animationFrameDuration, (timer) async {
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

  /// Generates a list containing the next faces of the dice.
  Future<List<int>> _generateIntermediateRoll(List<int> last) async {
    List<int> roll = await diceRepo.getNumbers(last.length);
    while (listEquals(roll, last)) {
      roll = await diceRepo.getNumbers(last.length);
    }
    return roll;
  }
}
