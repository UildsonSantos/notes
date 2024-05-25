import 'package:dartz/dartz.dart';
import 'package:note/core/error/error.dart';
import 'package:note/domain/entities/entities.dart';
import 'package:note/domain/repositories/repositories.dart';

class UpdateNote {
  final NoteRepository repository;

  UpdateNote(this.repository);

  Future<Either<Failure, void>> call(NoteEntity note) async {
    return await repository.updateNote(note);
  }
}
