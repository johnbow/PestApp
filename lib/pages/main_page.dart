import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';
import 'package:pest/widgets/player_counter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            PlayerCounter(playerCount: state.players),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  for (final line in state.message) Text(line),
                  GestureDetector(
                    onTap: () => context.read<GameCubit>().rollDices(),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final side in state.dices) DiceWidget(side: side)
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: state is RolledOut,
                    child: ElevatedButton(
                        onPressed: () => context.read<GameCubit>().startRound(),
                        child: const Text("weiter")),
                  ),
                  Visibility(
                    visible: state is RoundEnded,
                    child: ElevatedButton(
                        onPressed: () => context.read<GameCubit>().restart(),
                        child: const Text("Neue Runde")),
                  )
                ],
              ),
            ),
          ],
        );
      },
    ));
  }
}
