import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void setNoConsecutivePest(bool value) {
    print(value);
    emit(state.copyWith(noConsecutivePest: value));
  }
}
