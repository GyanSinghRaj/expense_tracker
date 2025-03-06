import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/features/data/models/budget_model.dart';
import 'package:expense_tracker/features/data/models/expense_model.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/user/auth_cubit.dart';
import 'package:expense_tracker/features/presentation/blocs/user/auth_state.dart';
import 'package:expense_tracker/features/presentation/blocs/user/user_display_cubit.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/add_budget_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/budget_details.dart';
import 'package:expense_tracker/features/presentation/pages/old/budget/update_budget.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/add_expense.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/expense_details.dart';
import 'package:expense_tracker/features/presentation/pages/old/expense_pages/update_expense.dart';
import 'package:expense_tracker/features/presentation/pages/old/home_page.dart';
import 'package:expense_tracker/features/presentation/pages/old/signup_page.dart';
import 'package:expense_tracker/locator.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  setupServiceLocator();
  await prefs.clear();
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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthStateCubit()..appStarted(),
        ),
        BlocProvider(
          create: (context) => UserDisplayCubit()..displayUser(),
        ),
        BlocProvider(create: (context) => sl<ExpenseBloc>()),
        BlocProvider(create: (context) => sl<BudgetBloc>()),
      ],
      child: MaterialApp(
          // theme: AppTheme.appTheme,
          routes: {
            '/add_budget': (context) => AddBudgetPage(),
            '/edit_budget': (context) => UpdateBudgetScreen(
                  budget:
                      ModalRoute.of(context)!.settings.arguments as BudgetModel,
                ),
            '/budget_details': (context) => BudgetDetailScreen(
                  budget:
                      ModalRoute.of(context)!.settings.arguments as BudgetModel,
                ),
            '/add_expense': (context) => AddExpenseForm(),
            '/edit_expense': (context) => UpdateExpenseForm(
                  expense: ModalRoute.of(context)!.settings.arguments
                      as ExpenseModel,
                ),
            '/expense_details': (context) => ExpenseDetailScreen(
                  expense: ModalRoute.of(context)!.settings.arguments
                      as ExpenseModel,
                ),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/add_budget') {
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: context.read<BudgetBloc>(),
                  child: AddBudgetPage(),
                ),
              );
            }
            if (settings.name == '/edit_expense') {
              return MaterialPageRoute(
                builder: (context) => BlocProvider.value(
                  value: context.read<ExpenseBloc>(),
                  child: UpdateExpenseForm(
                    expense: settings.arguments as ExpenseModel,
                  ),
                ),
              );
            }
            return null; // Let the routes table handle other routes
          },
          debugShowCheckedModeBanner: false,
          home: BlocBuilder<AuthStateCubit, AuthState>(
            builder: (context, state) {
              if (state is Authenticated) {
                return HomePage();
              }
              if (state is UnAuthenticated) {
                return SignUpPage();
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
