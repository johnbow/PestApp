import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dice_cubit_state.dart';

class DiceCubitCubit extends Cubit<DiceCubitState> {
  DiceCubitCubit() : super(DiceCubitInitial());
}
