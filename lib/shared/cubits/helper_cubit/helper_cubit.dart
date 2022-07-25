import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'helper_state.dart';

class HelperCubit extends Cubit<HelperState> {
  HelperCubit() : super(HelperInitial());
  static HelperCubit get(context) => BlocProvider.of(context);
  bool passwordVisiable = false;
  bool confirmPasswordVisiable = false;
  void togglePassword() {
    passwordVisiable = !passwordVisiable;
    emit(HelperRebuild());
  }

  void toggleConfirmPassword() {
    confirmPasswordVisiable = !confirmPasswordVisiable;
    emit(HelperRebuild());
  }

  void rebuildPart() {
    emit(HelperRebuild());
  }
  void rebuildConfetti() {
    emit(HelperRebuildConfetti());
  }
}
