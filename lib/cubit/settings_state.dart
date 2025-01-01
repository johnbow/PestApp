part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      {required this.noConsecutivePest,
      required this.showAnimations,
      required this.passingBehavior});

  final bool noConsecutivePest;
  final bool showAnimations;
  final int passingBehavior;

  @override
  List<Object> get props =>
      [noConsecutivePest, showAnimations, passingBehavior];

  SettingsState copyWith(
      {bool? noConsecutivePest, bool? showAnimations, int? passingBehavior}) {
    return SettingsState(
        noConsecutivePest: noConsecutivePest ?? this.noConsecutivePest,
        showAnimations: showAnimations ?? this.showAnimations,
        passingBehavior: passingBehavior ?? this.passingBehavior);
  }
}
