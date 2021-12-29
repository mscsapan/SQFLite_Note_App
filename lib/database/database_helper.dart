import 'package:flutter/material.dart';
import 'package:my_note_app/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NoteDBHelper {
  NoteDBHelper._noteDBHelper();

  static final NoteDBHelper noteHelper = NoteDBHelper._noteDBHelper();
  static Database? _database;
  static const _databaseName = 'note.db';
  static const _tableName = 'note';

  Future<Database?> get noteDatabase async {
    if (_database != null) return _database;

    return _database = await _initializingNoteDatabase();
  }

  _initializingNoteDatabase() async {
    var directory = await getDatabasesPath();
    String path = join(directory, _databaseName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<Database?> _onCreate(Database? database, int version) async {
    await database!.execute('''
    CREATE TABLE $_tableName(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL,
    description TEXT NOT NULL
    )
    
    ''');
  }

  Future<Note> insertNote(Note note) async {
    Database? db = await noteDatabase;
    debugPrint('${note.toNoteMap()}');
    await db!.insert(_tableName, note.toNoteMap());
    return note;
  }

  Future<List<Note>> getNoteList() async {
    Database? db = await noteDatabase;
    List<Map<String, Object?>> result = await db!.query(_tableName);
    return result.map((note) => Note.fromNote(note)).toList();
  }

  Future<int> deleteNote(int id) async {
    Database? db = await noteDatabase;
    return await db!.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future updateNote(Note note) async {
    Database? db = await noteDatabase;
    await db!.update(_tableName, note.toNoteMap(),
        where: 'id = ?', whereArgs: [note.id]);
  }
}
