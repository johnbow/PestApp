import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: BlocBuilder<GameCubit, GameState>(
            builder: (context, state) {
              return Text(
                  "${gameCubit.state.round} / ${gameCubit.state.players}");
            },
          ),
        ),
        IconButton(
            onPressed: () => gameCubit.restart(),
            icon: const Icon(Icons.replay))
      ],
    );
  }
}
