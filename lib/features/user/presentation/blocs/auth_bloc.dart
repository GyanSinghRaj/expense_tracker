import 'package:expense_tracker/features/user/domain/usecases/login_user.dart';
import 'package:expense_tracker/features/user/domain/usecases/logout_user.dart';
import 'package:expense_tracker/features/user/presentation/blocs/auth_event.dart';
import 'package:expense_tracker/features/user/presentation/blocs/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUser;
  final Logout logoutUser;
  AuthBloc(this.loginUser, this.logoutUser) : super(AuthLoading()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final uid = await loginUser(event.email, event.password);
        emit(AuthSuccess(uid));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      await logoutUser();
      emit(AuthLoading());
    });
  }
}
