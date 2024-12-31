import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/cubit/game_cubit.dart';

class PlayerCounter extends StatelessWidget {
  const PlayerCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              if (context.read<DiceCubit>().state is DiceRolling) return;
              context.read<GameCubit>().removePlayer();
            },
            icon: const Icon(Icons.remove, size: 30.0)),
        BlocBuilder<GameCubit, GameState>(
          builder: (context, state) {
            return Text("${state.players} Spieler",
                style: Theme.of(context).textTheme.titleLarge);
          },
        ),
        IconButton(
            onPressed: () {
              if (context.read<DiceCubit>().state is DiceRolling) return;
              context.read<GameCubit>().addPlayer();
            },
            icon: const Icon(Icons.add, size: 30.0))
      ],
    );
  }
}
