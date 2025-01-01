import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pest/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settings)
      : super(SettingsState(
            noConsecutivePest: settings.noConsecutivePest,
            showAnimations: settings.showAnimations,
            passingBehavior: settings.passingBehavior));

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

  void save() {
    settings.noConsecutivePest = state.noConsecutivePest;
    settings.showAnimations = state.showAnimations;
    settings.passingBehavior = state.passingBehavior;
  }
}
