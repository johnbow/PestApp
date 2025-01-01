class Settings {
  bool noConsecutivePest;
  bool showAnimations;
  bool bigGroupSetting;
  int passingBehavior;
  int? lastPest; // just keep track of this

  Settings(
      {this.noConsecutivePest = false,
      this.showAnimations = true,
      this.passingBehavior = PassingBehavior.afterNoDrinking,
      this.lastPest,
      this.bigGroupSetting = false});

  void reset() {
    noConsecutivePest = false;
    showAnimations = true;
    passingBehavior = PassingBehavior.afterNoDrinking;
    bigGroupSetting = false;
  }
}

class PassingBehavior {
  static const int afterNoDrinking = 0;
  static const int afterPestDoesNotDrink = 1;
  static const int immediate = 2;
}
