import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/pages/settings_dialog.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    "${gameCubit.state.round} / ${gameCubit.state.players}",
                    style: Theme.of(context).textTheme.titleLarge)),
            if (state is FirstStage || state is FirstStageEnded)
              IconButton(
                  onPressed: () => openSettings(context),
                  icon: const Icon(Icons.settings_outlined, size: 40.0))
            else
              IconButton(
                  onPressed: () => gameCubit.restart(),
                  icon: const Icon(Icons.replay, size: 30.0))
          ],
        );
      },
    );
  }
}
