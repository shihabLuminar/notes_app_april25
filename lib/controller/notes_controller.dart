import 'dart:developer';
import 'dart:io';

import 'package:notes_app/core/constants/db_constants.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:sqflite/sqflite.dart';

class NotesController {
  static List<NoteModel> notes = [];
  static late Database database;

  static Future<void> initializeDb() async {
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

  static Future<void> deleteNote() async {
    await getAllNotes();
  }

  static void shareNote() {}
}
