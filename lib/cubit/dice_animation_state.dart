part of 'dice_animation_cubit.dart';

@immutable
sealed class DiceAnimationState {
  const DiceAnimationState({required this.animating, required this.frame});

  final bool animating;
  final List<int> frame;

  DiceAnimationState copyWith({bool? animating, List<int>? frame});
}

final class DiceAnimationInProgress extends DiceAnimationState {
  const DiceAnimationInProgress({required super.frame})
      : super(animating: true);

  @override
  DiceAnimationInProgress copyWith(
      {bool? animating = false, List<int>? frame, List<int>? lastFrame}) {
    return DiceAnimationInProgress(frame: frame ?? this.frame);
  }
}

final class DiceAnimationFinished extends DiceAnimationState {
  const DiceAnimationFinished({required super.frame}) : super(animating: false);

  @override
  DiceAnimationState copyWith({bool? animating = false, List<int>? frame}) {
    return DiceAnimationFinished(frame: frame ?? this.frame);
  }
}
