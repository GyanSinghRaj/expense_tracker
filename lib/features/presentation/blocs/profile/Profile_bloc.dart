import 'package:expense_tracker/features/presentation/blocs/profile/profile_event.dart';
import 'package:expense_tracker/features/presentation/blocs/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileLoading()) {
    on<LoadProfile>((event, emit) async {
      await Future.delayed(Duration(seconds: 1)); // Simulate API call
      emit(ProfileLoaded(
        name: "John Doe",
        email: "johndoe@email.com",
        profilePic: "https://via.placeholder.com/150",
        totalExpenses: 1250.0,
        monthlyBudget: 3000.0,
      ));
    });

    on<UpdateProfile>((event, emit) {
      if (state is ProfileLoaded) {
        final currentState = state as ProfileLoaded;
        emit(ProfileLoaded(
          name: event.name,
          email: event.email,
          profilePic: currentState.profilePic,
          totalExpenses: currentState.totalExpenses,
          monthlyBudget: currentState.monthlyBudget,
        ));
      }
    });

    on<LogoutUser>((event, emit) {
      emit(ProfileLoading()); // Handle logout logic here
    });
  }
}
