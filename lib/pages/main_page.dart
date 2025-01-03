// pages have to be rebuild, so do not use const here
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/dice_animation_cubit.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/pages/first_stage_page.dart';
import 'package:pest/pages/second_stage_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: MultiBlocListener(
        listeners: [
          BlocListener<GameCubit, GameState>(
            listenWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
            listener: (context, state) {
              switch (state) {
                case FirstStage():
                  context.read<DiceCubit>().resetFirst();
                  context.read<DiceAnimationCubit>().resetFirst();
                case SecondStage():
                  context.read<DiceCubit>().resetSecond();
                  context.read<DiceAnimationCubit>().resetSecond();
                default:
                  break;
              }
            },
          ),
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
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return switch (state) {
              FirstStage() => FirstStagePage(),
              FirstStageEnded() => FirstStagePage(),
              SecondStage() => SecondStagePage(),
              SecondStageEnded() => SecondStagePage(),
            };
          },
        ),
      ),
    ));
  }
}
