import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';

class DiceWidgetGroup extends StatelessWidget {
  const DiceWidgetGroup({super.key});

  @override
  Widget build(BuildContext context) {
    final gameState = context.read<GameCubit>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<DiceCubit, DiceState>(
          listener: (context, state) {
            if (state is DiceRolling) {
              // tapped on dice
              context.read<DiceAnimationCubit>().startAnimation(state.roll);
            } else if (state is DiceRolled) {
              context.read<GameCubit>().notifyRollFinished(state.roll);
            }
          },
        ),
        BlocListener<DiceAnimationCubit, DiceAnimationState>(
          listener: (context, state) {
            if (state is DiceAnimationFinished) {
              context.read<DiceCubit>().notifyRollFinished();
            }
          },
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => {
          if (gameState is FirstStage || gameState is SecondStage)
            {
              context
                  .read<DiceCubit>()
                  .rollDice(gameState.numDice, gameState.round)
            }
        },
        child: BlocBuilder<DiceAnimationCubit, DiceAnimationState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final side in state.frame) DiceWidget(side: side)
              ],
            );
          },
        ),
      ),
    );
  }
}
