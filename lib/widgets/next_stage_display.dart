import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pest/constants/themes.dart';
import 'package:pest/cubit/game_cubit.dart';
import 'package:pest/widgets/dice_widget_group.dart';

class NextStageDisplay extends StatelessWidget {
  const NextStageDisplay({super.key, required this.actionText, this.message});

  final Widget? actionText;
  final Widget? message;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IntrinsicWidth(
            child: ElevatedButton(
                style: roundButtonStyle,
                onPressed: context.read<GameCubit>().nextStage,
                child: actionText),
          ),
          if (message != null) message!,
          const DiceWidgetGroup(),
        ],
      ),
    );
  }
}
