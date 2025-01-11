// pages have to be rebuild, so do not use const here
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/pages/first_stage_page.dart';
import 'package:pest/pages/second_stage_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
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
    ));
  }
}
