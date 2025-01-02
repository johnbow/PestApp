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
    final gameCubit = context.read<GameCubit>();
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => {
        if (gameCubit.state is FirstStage || gameCubit.state is SecondStage)
          {
            context
                .read<DiceCubit>()
                .rollDice(gameCubit.state.numDice, gameCubit.state.round)
          }
      },
      child: BlocBuilder<DiceAnimationCubit, DiceAnimationState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final side in state.frame) DiceWidget(side: side)
              ],
            ),
          );
        },
      ),
    );
  }
}
