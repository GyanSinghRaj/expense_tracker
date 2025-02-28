import 'package:expense_tracker/core/network/dio_client.dart';
import 'package:expense_tracker/features/data/data_sources/auth_api_service.dart';
import 'package:expense_tracker/features/data/data_sources/auth_local_service.dart';
import 'package:expense_tracker/features/data/repository/auth_repository_impl.dart';
import 'package:expense_tracker/features/domain/repositories/auth_repository.dart';
import 'package:expense_tracker/features/domain/usecases/user/get_user.dart';
import 'package:expense_tracker/features/domain/usecases/user/is_logged_in.dart';
import 'package:expense_tracker/features/domain/usecases/user/log_out.dart';
import 'package:expense_tracker/features/domain/usecases/user/sign_in.dart';
import 'package:expense_tracker/features/domain/usecases/user/sign_up.dart';

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton<DioClient>(DioClient());

  // Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  // sl.registerSingleton<NoteApiService>(NoteApiServiceImpl());

  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());

  // Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  // sl.registerSingleton<NoteRepository>(NoteRepositoryImpl());

  // Usecases
  sl.registerSingleton<SignupUseCase>(SignupUseCase());

  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());

  sl.registerSingleton<GetUserUseCase>(GetUserUseCase());

  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());

  sl.registerSingleton<SigninUseCase>(SigninUseCase());
  //noteusecase
  // sl.registerSingleton<DeleteNote>(DeleteNote());
  // sl.registerSingleton<CreateNote>(CreateNote());
  // sl.registerSingleton<UpdateNote>(UpdateNote());
  // sl.registerSingleton<GetNotes>(GetNotes());

  // sl.registerFactory(() => NoteBloc(
  //       getNotes: sl(),
  //       addNote: sl(),
  //       updateNote: sl(),
  //       deleteNote: sl(),
  //     ));
}
