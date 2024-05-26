import 'package:note/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  final tableName = 'note';
  final id = 'id';
  final title = 'title';
  final content = 'content';
  final createdAt = 'createdAt';
  final updatedAt = 'updatedAt';
  final isArchived = 'isArchived';
  final isPinned = 'isPinned';
  final isCompleted = 'isCompleted';

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'notes_app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $id TEXT PRIMARY KEY,
        $title TEXT NOT NULL,
        $content TEXT,
        $createdAt TEXT,
        $updatedAt TEXT,
        $isArchived INTEGER,
        $isPinned INTEGER,
        $isCompleted INTEGER
      )
    ''');
  }

  Future<NoteModel> add(NoteModel note) async {
    final db = await database;
    final id = await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // Criar um novo NoteModel com o ID atualizado
    final noteWithId = note.copyWith(id: id.toString());
    return noteWithId;
  }

  Future<List<NoteModel>> fetch() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
    );
    final notes = List.generate(maps.length, (i) {
      return NoteModel.fromMap(maps[i]);
    });
    return notes;
  }

  Future<int?> update(NoteModel note) async {
    final db = await database;
    final rowsAffected = await db.update(
      tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    return rowsAffected;
  }

  Future<int?> delete(int id) async {
    final db = await database;
    final rowsDeleted = await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsDeleted;
  }
}
