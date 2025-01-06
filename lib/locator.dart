import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/features/expense/data/datasources/expense_remote_datasource.dart';
import 'package:expense_tracker/features/expense/data/repositories/expense_repository_impl.dart';
import 'package:expense_tracker/features/expense/domain/repositories/expense_repository.dart';
import 'package:expense_tracker/features/expense/domain/usecases/fetch_expense.dart';
import 'package:expense_tracker/features/expense/presentation/blocs/expense_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  // Firebase
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Data layer
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
      () => ExpenseRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ExpenseRepository>(
      () => ExpenseRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => FetchExpenses(sl()));

  // BLoC
  sl.registerFactory(() => ExpenseBloc(sl()));
}
