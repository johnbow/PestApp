import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pest/cubit/dice_cubit.dart';
import 'package:pest/widgets/dice_widget_group.dart';

class DiceDisplay extends StatelessWidget {
  const DiceDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Gap(24.0),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 80),
            child: BlocBuilder<DiceCubit, DiceState>(
              builder: (context, state) {
                return MessageDisplay(state: state);
              },
            ),
          ),
          const Expanded(child: DiceWidgetGroup()),
        ],
      ),
    );
  }
}

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({super.key, required this.state});

  final DiceState state;

  @override
  Widget build(BuildContext context) {
    final message = switch (state) {
      DiceInitial s => s.message,
      DiceRolled s => s.message,
      DiceRolling() => [""],
    };
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final line in message)
          Text(
            line,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: line == "Weitergeben" ? Colors.lightGreen : null),
          ),
      ],
    );
  }
}
