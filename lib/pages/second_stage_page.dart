import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/bottom_bar.dart';
import 'package:pest/widgets/dice_display.dart';
import 'package:pest/widgets/next_stage_display.dart';
import 'package:pest/widgets/player_counter.dart';

class SecondStagePage extends StatelessWidget {
  const SecondStagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const PlayerCounter(),
        if (context.read<GameCubit>().state is SecondStageEnded)
          NextStageDisplay(
              actionText: Text(
            "Neues Spiel",
            style: Theme.of(context).textTheme.headlineMedium,
          ))
        else
          const DiceDisplay(),
        const BottomBar(),
      ],
    );
  }
}
