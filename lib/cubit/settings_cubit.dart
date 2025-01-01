import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pest/repositories/settings_repository.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this.settings)
      : super(SettingsState(
            noConsecutivePest: settings.noConsecutivePest,
            showAnimations: settings.showAnimations,
            expressRound: settings.expressRound,
            animationFrameDurationMs: settings.animationFrameDurationMs));

  final Settings settings;

  void setNoConsecutivePest(bool value) {
    emit(state.copyWith(noConsecutivePest: value));
  }

  void setShowAnimations(bool value) {
    emit(state.copyWith(showAnimations: value));
  }

  void save() {
    settings.noConsecutivePest = state.noConsecutivePest;
    settings.showAnimations = state.showAnimations;
    settings.expressRound = state.expressRound;
    settings.animationFrameDurationMs = state.animationFrameDurationMs;
  }
}
