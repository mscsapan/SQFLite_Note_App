import 'package:flutter/material.dart';
import 'package:my_note_app/database/database_helper.dart';
import 'package:my_note_app/model/model.dart';

class NoteController with ChangeNotifier {
  late Future<List<Note>> _getNote;

  Future<List<Note>> get getNote => _getNote;

  Future<List<Note>> getInsertedNote() async {
    return _getNote = NoteDBHelper.noteHelper.getNoteList();
  }
}
