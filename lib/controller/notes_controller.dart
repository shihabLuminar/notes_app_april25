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

  static void addNote() {}

  static void updateNote() {}
  static void deleteNote() {}
  static void getAllNotes() {}
  static void shareNote() {}
}
