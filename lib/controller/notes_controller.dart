import 'package:flutter/foundation.dart';
import 'package:notes_app/core/constants/db_constants.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class NotesController {
  static List<NoteModel> notes = [];
  static late Database database;

  static Future<void> initializeDb() async {
    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
    }
    database = await openDatabase(
      "notes.db",
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE ${DBConstants.notes} (${DBConstants.noteId} INTEGER PRIMARY KEY, ${DBConstants.notetitle} TEXT, ${DBConstants.noteDesc} TEXT, ${DBConstants.noteDate} TEXT)",
        );
      },
    );
  }

  static Future<void> addNote({
    required String title,
    required String description,
    required String date,
  }) async {
    await database.rawInsert(
      'INSERT INTO ${DBConstants.notes}(${DBConstants.notetitle}, ${DBConstants.noteDesc}, ${DBConstants.noteDate}) VALUES(?, ?, ?)',
      [title, description, date],
    );
    await getAllNotes();
  }

  static Future<void> getAllNotes() async {
    List data = await database.rawQuery('SELECT * FROM ${DBConstants.notes}');

    notes =
        data
            .map(
              (note) => NoteModel(
                id: note[DBConstants.noteId],
                title: note[DBConstants.notetitle],
                description: note[DBConstants.noteDesc],
                date: note[DBConstants.noteDate],
              ),
            )
            .toList();
  }

  static Future<void> updateNote() async {
    await getAllNotes();
  }

  static Future<void> deleteNote(int id) async {
    await database.rawDelete(
      'DELETE FROM ${DBConstants.notes} WHERE ${DBConstants.noteId} = ?',
      [id],
    );
    await getAllNotes();
  }

  static void shareNote() {}
}
