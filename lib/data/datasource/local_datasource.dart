import 'package:note/data/datasource/db/database_helper.dart';
import 'package:note/data/models/models.dart';

abstract class NoteDataSource {
  Future<NoteModel> addNote(NoteModel note);
  Future<int?> updateNote(NoteModel note);
  Future<int?> deleteNote(int id);
  Future<List<NoteModel>> fetchNotes();
}

class NoteLocalDataSourceImpl implements NoteDataSource {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<NoteModel> addNote(NoteModel note) => _databaseHelper.add(note);

  @override
  Future<int?> deleteNote(int noteId) => _databaseHelper.delete(noteId);

  @override
  Future<List<NoteModel>> fetchNotes() => _databaseHelper.fetch();

  @override
  Future<int?> updateNote(NoteModel note) => _databaseHelper.update(note);
}
