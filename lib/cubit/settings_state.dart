part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      {required this.noConsecutivePest,
      required this.showAnimations,
      required this.passingBehavior,
      required this.bigGroupSetting});

  final bool noConsecutivePest;
  final bool showAnimations;
  final bool bigGroupSetting;
  final int passingBehavior;

  @override
  List<Object> get props =>
      [noConsecutivePest, showAnimations, passingBehavior, bigGroupSetting];

  SettingsState copyWith(
      {bool? noConsecutivePest,
      bool? showAnimations,
      int? passingBehavior,
      bool? bigGroupSetting}) {
    return SettingsState(
        noConsecutivePest: noConsecutivePest ?? this.noConsecutivePest,
        showAnimations: showAnimations ?? this.showAnimations,
        passingBehavior: passingBehavior ?? this.passingBehavior,
        bigGroupSetting: bigGroupSetting ?? this.bigGroupSetting);
  }
}
