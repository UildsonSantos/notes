import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/domain/entities/entities.dart';

abstract class NoteRepository {
  Future<Either<Failure, void>> addNote(NoteEntity note);
  Future<Either<Failure, void>> updateNote(NoteEntity note);
  Future<Either<Failure, void>> deleteNote(String id);
  Future<Either<Failure, List<NoteEntity>>> getNotes();
}
