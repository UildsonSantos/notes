import 'package:get_it/get_it.dart';
import 'package:note/data/datasource/datasource.dart';
import 'package:note/data/repositories/repositories.dart';
import 'package:note/domain/repositories/repositories.dart';
import 'package:note/domain/usecases/usecases.dart';
import 'package:note/presentation/blocs/blocs.dart';

final sl = GetIt.instance; // sl stands for service locator

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => NoteBloc(sl(), sl(), sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => FetchNotes(sl()));
  sl.registerLazySingleton(() => AddNote(sl()));
  sl.registerLazySingleton(() => DeleteNote(sl()));
  sl.registerLazySingleton(() => UpdateNote(sl()));

  // Repository
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<NoteDataSource>(
    () => NoteLocalDataSourceImpl(),
  );

  // Database Helper
  sl.registerLazySingleton(() => DatabaseHelper());
}
