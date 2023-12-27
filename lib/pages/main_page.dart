import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/constants/themes.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget_group.dart';
import 'package:pest/widgets/player_counter.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  bool _isRoundStartedState(GameState state) {
    return state is RoundStarted ||
        state is RoundEnded ||
        (state is DiceRolling &&
            (state.nextState is RoundStarted || state.nextState is RoundEnded));
  }

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
                    const DiceWidgetGroup(),
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
              if (_isRoundStartedState(state))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: state is RoundEnded
                          ? Text("${state.players} / ${state.players}")
                          : Text("${state.round} / ${state.players}"),
                    ),
                    IconButton(
                        onPressed: () => context.read<GameCubit>().restart(),
                        icon: const Icon(Icons.replay))
                  ],
                )
            ],
          ),
        );
      },
    ));
  }
}
