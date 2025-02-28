import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/features/presentation/blocs/user/auth_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/auth_state.dart';
import 'package:expense_tracker/features/presentation/pages/home_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/login_page.dart';
import 'package:expense_tracker/features/presentation/pages/signup_page.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black));
  setupServiceLocator();
  runApp(
    BlocProvider(
      create: (context) => sl<AuthStateCubit>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: LoginPage());
  }
}

  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: [SystemUiOverlay.bottom]);
  //   return BlocProvider(
  //     create: (context) => AuthStateCubit()..appStarted(),
  //     child: MaterialApp(
  //         theme: AppTheme.appTheme,
  //         // routes: {
  //         //   // '/': (context) => const NoteScreen(),
  //         //   '/add_note': (context) => const AddNoteScreen(),
  //         //   '/edit_note': (context) => EditNoteScreen(
  //         //         note: ModalRoute.of(context)!.settings.arguments as NoteModel,
  //         //       ),
  //         //   '/note_detail': (context) => NoteDetailScreen(
  //         //         note: ModalRoute.of(context)!.settings.arguments as NoteModel,
  //         //       ),
  //         // },
  //         // onGenerateRoute: (settings) {
  //         //   if (settings.name == '/add_note') {
  //         //     return MaterialPageRoute(
  //         //       builder: (context) => BlocProvider.value(
  //         //         value: context.read<NoteBloc>(),
  //         //         child: const AddNoteScreen(),
  //         //       ),
  //         //     );
  //         //   }
  //         //   // Similar pattern for edit_note and note_detail
  //         //   return null; // Let the routes table handle other routes
  //         // },
  //         debugShowCheckedModeBanner: false,
  //         home: BlocBuilder<AuthStateCubit, AuthState>(
  //           builder: (context, state) {
  //             if (state is Authenticated) {
  //               return const HomePage();
  //             }
  //             if (state is UnAuthenticated) {
  //               return SignupPage();
  //             }
  //             return Container();
  //           },
  //         )),
  //   );
  // }

