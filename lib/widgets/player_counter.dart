import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';

class PlayerCounter extends StatelessWidget {
  const PlayerCounter({super.key, required this.playerCount});

  final int playerCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => context.read<GameCubit>().removePlayer(),
            icon: const Icon(Icons.remove)),
        Text("$playerCount Spieler"),
        IconButton(
            onPressed: () => context.read<GameCubit>().addPlayer(),
            icon: const Icon(Icons.add))
      ],
    );
  }
}
