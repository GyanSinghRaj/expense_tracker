import 'package:expense_tracker/features/domain/entities/user_entity.dart';
import 'package:expense_tracker/features/domain/usecases/user/log_out.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_state.dart';
import 'package:expense_tracker/features/presentation/widgets/basic_app_button.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_cubit.dart';
import 'package:expense_tracker/features/presentation/widgets/button_cubit/button_state.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Handle add new note
            },
          ),
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserDisplayCubit()..displayUser()),
          BlocProvider(create: (context) => ButtonStateCubit()),
          // BlocProvider(create: (context)=>NOte..getNotes())
        ],
        child: BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonSuccessState) {
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SignupPage(),
              //     ));
            }
          },
          child: SingleChildScrollView(
            child: BlocBuilder<UserDisplayCubit, UserDisplayState>(
              builder: (context, state) {
                if (state is UserLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is UserLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          // _username(state.userEntity),
                          const SizedBox(
                            height: 10,
                          ),
                          // _email(state.userEntity),
                          _logout(context),
                        ],
                      ),
                      TextButton(
                          onPressed: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => NoteScreen()));
                          },
                          child: Text(
                            "Notes",
                            style: TextStyle(color: Colors.red, fontSize: 28),
                          ))
                    ],
                  );
                }
                if (state is LoadUserFailure) {
                  return Text(
                    state.errorMessage,
                    style: TextStyle(color: Colors.red),
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _username(UserEntity user) {
    return Text(
      user.username,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _email(UserEntity user) {
    return Text(
      user.email,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    );
  }

  Widget _logout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: BasicAppButton(
          title: 'Logout',
          onPressed: () {
            context
                .read<ButtonStateCubit>()
                .execute(usecase: sl<LogoutUseCase>());
          }),
    );
  }
}
