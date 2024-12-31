import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/pages/settings_dialog.dart';
import 'package:pest/widgets/bottom_bar.dart';
import 'package:pest/widgets/dice_display.dart';
import 'package:pest/widgets/next_stage_display.dart';
import 'package:pest/widgets/player_counter.dart';

class FirstStagePage extends StatelessWidget {
  const FirstStagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PlayerCounter(),
        if (context.read<GameCubit>().state is FirstStageEnded)
          NextStageDisplay(
            actionText: Text(
              "Weiter",
              style: Theme.of(context).textTheme.displayMedium,
            ),
            message: const PestMessage(),
          )
        else
          const DiceDisplay(),
        const BottomBar(),
      ],
    );
  }
}

class PestMessage extends StatelessWidget {
  const PestMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
        style: Theme.of(context).textTheme.displaySmall,
        text: "Du bist ",
      ),
      TextSpan(
        text: "Pest!",
        style: Theme.of(context)
            .textTheme
            .displaySmall!
            .copyWith(color: Colors.red),
      )
    ]));
  }
}
