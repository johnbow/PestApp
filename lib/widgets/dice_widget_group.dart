import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget.dart';

class DiceWidgetGroup extends StatelessWidget {
  const DiceWidgetGroup({super.key, required this.dices});

  final List<int> dices;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<GameCubit>().rollDices(),
      child: Column(
        children: [for (final side in dices) DiceWidget(side: side)],
      ),
    );
  }
}
