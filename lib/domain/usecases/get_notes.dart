import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/domain/repositories/repositories.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<Either<Failure, List<NoteEntity>>> call() async {
    return await repository.getNotes();
  }
}
