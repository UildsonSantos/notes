import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/domain/repositories/repositories.dart';

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<Either<Failure, int?>> call(int id) async {
    return await repository.deleteNote(id);
  }
}
