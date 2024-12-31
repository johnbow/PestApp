part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  const SettingsState(
      {required this.noConsecutivePest,
      required this.expressRound,
      required this.showAnimations,
      required this.animationFrameDurationMs});

  final bool noConsecutivePest;
  final bool expressRound;
  final bool showAnimations;
  final int animationFrameDurationMs;

  @override
  List<Object> get props => [
        noConsecutivePest,
        expressRound,
        showAnimations,
        animationFrameDurationMs
      ];

  SettingsState copyWith(
      {bool? noConsecutivePest,
      bool? expressRound,
      bool? showAnimations,
      int? animationFrameDurationMs}) {
    return SettingsState(
        noConsecutivePest: noConsecutivePest ?? this.noConsecutivePest,
        expressRound: expressRound ?? this.expressRound,
        showAnimations: showAnimations ?? this.showAnimations,
        animationFrameDurationMs:
            animationFrameDurationMs ?? this.animationFrameDurationMs);
  }
}
