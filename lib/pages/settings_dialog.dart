import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pest/cubit/settings_cubit.dart';
import 'package:pest/repositories/settings_repository.dart';

Future<void> openSettings(BuildContext context) async {
  await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (diaContext) => BlocProvider.value(
            value: context.read<SettingsCubit>(),
            child: const Dialog(child: SettingsDialog()),
          ));
}

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>();
    final labelStyle = Theme.of(context).textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Einstellungen",
                  style: Theme.of(context).textTheme.titleLarge),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Zweimal Pest hintereinander verbieten: ",
                      softWrap: true,
                      style: labelStyle,
                    ),
                  ),
                  const Gap(10.0),
                  Checkbox(
                      value: state.noConsecutivePest,
                      onChanged: (newValue) =>
                          settings.setNoConsecutivePest(newValue!))
                ],
              ),
              const Gap(5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("Animationen zeigen: ",
                        softWrap: true, style: labelStyle),
                  ),
                  const Gap(10.0),
                  Checkbox(
                      value: state.showAnimations,
                      onChanged: (newValue) =>
                          settings.setShowAnimations(newValue!))
                ],
              ),
              const Gap(5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text("Einstellung für große Gruppen: ",
                        softWrap: true, style: labelStyle),
                  ),
                  const Gap(10.0),
                  Checkbox(
                      value: state.bigGroupSetting,
                      onChanged: (newValue) =>
                          settings.setBigGroupSetting(newValue!))
                ],
              ),
              const Gap(3.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DropdownMenu<int>(
                    helperText: "Weitergeben wenn",
                    initialSelection: state.passingBehavior,
                    onSelected: (value) => settings.setPassingBehavior(value!),
                    requestFocusOnTap: false,
                    inputDecorationTheme: const InputDecorationTheme(
                        border: UnderlineInputBorder()),
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                          value: PassingBehavior.afterNoDrinking,
                          label: "Keiner trinkt"),
                      DropdownMenuEntry(
                          value: PassingBehavior.afterPestDoesNotDrink,
                          label: "Pest nicht trinkt"),
                      DropdownMenuEntry(
                          value: PassingBehavior.immediate, label: "Sofort"),
                    ],
                  )
                ],
              ),
              const Gap(20.0),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                    onPressed: settings.reset,
                    child: Text("Zurücksetzen",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error))),
                const Gap(5.0),
                TextButton(
                    onPressed: () {
                      settings.save();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Schließen")),
              ])
            ],
          );
        },
      ),
    );
  }
}
