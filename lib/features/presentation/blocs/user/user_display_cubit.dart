import 'package:expense_tracker/features/domain/usecases/user/get_user.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_state.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDisplayCubit extends Cubit<UserDisplayState> {
  UserDisplayCubit() : super(UserLoading());

  void displayUser() async {
    emit(UserLoading());
    var result = await sl<GetUserUseCase>().call();
    result.fold((error) {
      emit(LoadUserFailure(errorMessage: error));
    }, (data) {
      emit(UserLoaded(userModel: data));
    });
  }
}
