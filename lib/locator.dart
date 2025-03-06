import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/features/data/data_sources/auth_api_service.dart';
import 'package:expense_tracker/features/data/data_sources/auth_local_service.dart';
import 'package:expense_tracker/features/data/data_sources/budget_api_service.dart';
import 'package:expense_tracker/features/data/data_sources/category_api_service.dart';
import 'package:expense_tracker/features/data/data_sources/expense_api_service.dart';
import 'package:expense_tracker/features/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/data/repository/budget_repository_impl.dart';
import 'package:expense_tracker/features/data/repository/category_repository_impl.dart';
import 'package:expense_tracker/features/data/repository/expense_repository_impl.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/features/domain/repositories/budget_repository.dart';
import 'package:expense_tracker/features/domain/repositories/category_repository.dart';
import 'package:expense_tracker/features/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/features/domain/usecases/budget/create_budget.dart';
import 'package:expense_tracker/features/domain/usecases/budget/delete_budget.dart';
import 'package:expense_tracker/features/domain/usecases/budget/get_budgets.dart';
import 'package:expense_tracker/features/domain/usecases/budget/update_budget.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/create_epense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/delete_epense.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/get_expenses.dart';
import 'package:expense_tracker/features/domain/usecases/expenses/update_expense.dart';
import 'package:expense_tracker/features/domain/usecases/user/get_user.dart';
import 'package:expense_tracker/features/domain/usecases/user/is_logged_in.dart';
import 'package:expense_tracker/features/domain/usecases/user/log_out.dart';
import 'package:expense_tracker/features/domain/usecases/user/sign_in.dart';
import 'package:expense_tracker/features/domain/usecases/user/sign_up.dart';
import 'package:expense_tracker/features/presentation/blocs/budget/budget_bloc.dart';
import 'package:expense_tracker/features/presentation/blocs/expense/expense_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<CategoryApiService>(CategoryApiServiceImpl());
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<ExpenseApiService>(ExpenseApiServiceImpl());
  sl.registerSingleton<BudgetApiService>(BudgetApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<ExpenseRepository>(ExpenseRepositoryImpl());
  sl.registerSingleton<BudgetRepository>(BudgetRepositoryImpl());
  sl.registerSingleton<CategoryRepository>(
      CategoryRepositoryImpl(sl<CategoryApiService>()));

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<SigninUseCase>(SigninUseCase());

  // Budget use cases
  sl.registerSingleton<DeleteBudget>(DeleteBudget());
  sl.registerSingleton<CreateBudget>(CreateBudget());
  sl.registerSingleton<UpdateBudget>(UpdateBudget());
  sl.registerSingleton<GetBudgets>(GetBudgets());

  sl.registerFactory(() => BudgetBloc(
        getBudgets: sl<GetBudgets>(),
        addBudget: sl<CreateBudget>(),
        updateBudget: sl<UpdateBudget>(),
        deleteBudget: sl<DeleteBudget>(),
      ));

  // Expense use cases
  sl.registerSingleton<DeleteExpense>(DeleteExpense());
  sl.registerSingleton<CreateExpense>(CreateExpense());
  sl.registerSingleton<UpdateExpense>(UpdateExpense());
  sl.registerSingleton<GetExpenses>(GetExpenses());

  sl.registerFactory(() => ExpenseBloc(
        getExpenses: sl<GetExpenses>(),
        addExpense: sl<CreateExpense>(),
        updateExpense: sl<UpdateExpense>(),
        deleteExpense: sl<DeleteExpense>(),
      ));
}
