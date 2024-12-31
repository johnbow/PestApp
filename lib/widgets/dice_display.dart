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
          const Gap(12.0),
          SizedBox(
            height: 80,
            child: BlocBuilder<DiceCubit, DiceState>(
              builder: (context, state) {
                return switch (state) {
                  DiceRolled() => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final line in state.message)
                          Text(
                            line,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                      ],
                    ),
                  DiceRolling() => const Text("")
                };
              },
            ),
          ),
          const Expanded(child: DiceWidgetGroup()),
        ],
      ),
    );
  }
}
