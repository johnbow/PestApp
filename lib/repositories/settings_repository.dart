class Settings {
  bool noConsecutivePest;
  bool showAnimations;
  int passingBehavior;
  int? lastPest;

  Settings(
      {this.noConsecutivePest = false,
      this.showAnimations = true,
      this.passingBehavior = PassingBehavior.afterNoDrinking,
      this.lastPest});
}

class PassingBehavior {
  static const int afterNoDrinking = 0;
  static const int afterPestDoesNotDrink = 1;
  static const int immediate = 2;
}
