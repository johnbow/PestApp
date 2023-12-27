import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/constants/themes.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';
import 'package:pest/widgets/player_counter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              PlayerCounter(playerCount: state.players),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    for (final line in state.message)
                      Text(
                        line,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => context.read<GameCubit>().rollDices(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (final side in state.dices) DiceWidget(side: side)
                        ],
                      ),
                    ),
                    Visibility(
                      visible: state is RolledOut,
                      child: ElevatedButton(
                          style: roundButtonStyle,
                          onPressed: () =>
                              context.read<GameCubit>().startRound(),
                          child: const Text("weiter")),
                    ),
                    Visibility(
                      visible: state is RoundEnded,
                      child: ElevatedButton(
                          style: roundButtonStyle,
                          onPressed: () => context.read<GameCubit>().restart(),
                          child: const Text("Neue Runde")),
                    ),
                  ],
                ),
              ),
              if (state is RoundStarted)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("${state.round} / ${state.players}"),
                    ),
                    IconButton(
                        onPressed: () => context.read<GameCubit>().restart(),
                        icon: Icon(Icons.replay))
                  ],
                )
            ],
          ),
        );
      },
    ));
  }
}
