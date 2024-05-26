import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/core/exceptions/exceptions.dart';
import 'package:note/data/datasource/datasource.dart';
import 'package:note/data/models/models.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/domain/repositories/repositories.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSourceImpl _dataSource;

  NoteRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, NoteEntity>> addNote(NoteEntity note) async {
    try {
      final result = await _dataSource.addNote(note as NoteModel);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure('Failed to add note: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, int?>> deleteNote(int id) async {
    try {
      final result = await _dataSource.deleteNote(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure('Failed to delete note: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> fetchNotes() async {
    try {
      final result = await _dataSource.fetchNotes();
      // Convertendo List<NoteModel> para List<NoteEntity>
      final entities = result.map((model) => model as NoteEntity).toList();
      return Right(entities);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure('Failed to get notes: ${e.message}'));
    }
  }

  @override
  Future<Either<Failure, int?>> updateNote(NoteEntity note) async {
    try {
      final result = await _dataSource.updateNote(note as NoteModel);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure('Failed to update note: ${e.message}'));
    }
  }
}
