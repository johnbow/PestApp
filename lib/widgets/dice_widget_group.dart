import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';

class DiceWidgetGroup extends StatelessWidget {
  const DiceWidgetGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GameCubit, GameState>(
          listener: (context, state) {
            if (state is DiceRolling) {
              context.read<DiceAnimationCubit>().startAnimation(state.dices);
            } else if (state is RoundStarted || state is RollingOut) {
              context.read<DiceAnimationCubit>().checkRefresh(state.dices);
            }
          },
        ),
        BlocListener<DiceAnimationCubit, DiceAnimationState>(
          listener: (context, state) {
            if (state is! DiceAnimationFinished) return;
            context.read<GameCubit>().onAnimationFinished();
          },
        ),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => context.read<GameCubit>().rollDices(),
        child: BlocBuilder<DiceAnimationCubit, DiceAnimationState>(
          builder: (context, state) {
            return Column(
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
