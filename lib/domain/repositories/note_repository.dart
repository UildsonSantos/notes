import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/domain/entities/entities.dart';

abstract class NoteRepository {
  Future<Either<Failure, NoteEntity>> addNote(NoteEntity note);
  Future<Either<Failure, int?>> updateNote(NoteEntity note);
  Future<Either<Failure, int?>> deleteNote(int id);
  Future<Either<Failure, List<NoteEntity>>> fetchNotes();
}
