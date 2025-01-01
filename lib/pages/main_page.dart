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
      child: BlocListener<GameCubit, GameState>(
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
        child: BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return switch (state) {
              FirstStage() => const FirstStagePage(),
              FirstStageEnded() => const FirstStagePage(),
              SecondStage() => const SecondStagePage(),
              SecondStageEnded() => const SecondStagePage(),
            };
          },
        ),
      ),
    ));
  }
}
