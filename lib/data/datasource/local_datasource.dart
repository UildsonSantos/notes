import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/data/datasource/db/database_helper.dart';
import 'package:note/data/models/models.dart';

abstract class NoteDataSource {
  Future<Either<Failure, NoteModel>> addNote(NoteModel note);
  Future<Either<Failure, int>> updateNote(NoteModel note);
  Future<Either<Failure, int>> deleteNote(int id);
  Future<Either<Failure, List<NoteModel>>> getNotes();
}

class NoteLocalDataSourceImpl implements NoteDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<Either<Failure, NoteModel>> addNote(NoteModel note) =>
      _databaseHelper.add(note);

  @override
  Future<Either<Failure, int>> deleteNote(int noteId) =>
      _databaseHelper.delete(noteId);

  @override
  Future<Either<Failure, List<NoteModel>>> getNotes() => _databaseHelper.get();

  @override
  Future<Either<Failure, int>> updateNote(NoteModel note) =>
      _databaseHelper.update(note);
}
