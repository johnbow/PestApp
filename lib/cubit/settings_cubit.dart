import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pest/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settings)
      : super(SettingsState(
            noConsecutivePest: settings.noConsecutivePest,
            showAnimations: settings.showAnimations,
            passingBehavior: settings.passingBehavior,
            bigGroupSetting: settings.bigGroupSetting));

  final Settings settings;

  void setNoConsecutivePest(bool value) {
    emit(state.copyWith(noConsecutivePest: value));
  }

  void setShowAnimations(bool value) {
    emit(state.copyWith(showAnimations: value));
  }

  void setPassingBehavior(int value) {
    emit(state.copyWith(passingBehavior: value));
  }

  void setBigGroupSetting(bool value) {
    final pb =
        value ? PassingBehavior.afterPestDoesNotDrink : state.passingBehavior;
    final ncp = value ? true : state.noConsecutivePest;
    emit(state.copyWith(
        bigGroupSetting: value, passingBehavior: pb, noConsecutivePest: ncp));
  }

  void save() {
    settings.noConsecutivePest = state.noConsecutivePest;
    settings.showAnimations = state.showAnimations;
    settings.passingBehavior = state.passingBehavior;
    settings.bigGroupSetting = state.bigGroupSetting;
  }
}
