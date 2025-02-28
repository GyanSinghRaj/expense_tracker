import 'package:expense_tracker/features/domain/usecases/user/is_logged_in.dart';
import 'package:expense_tracker/features/presentation/blocs/user/auth_state.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthStateCubit extends Cubit<AuthState> {

  AuthStateCubit() : super(AppInitialState());

  void appStarted() async {
    var isLoggedIn = await sl<IsLoggedInUseCase>().call();
    if (isLoggedIn) {
      emit(Authenticated());
    } else {
      emit(UnAuthenticated());
    }
  }

}