import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_controller.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/view/widget/note_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  void initState() {
    getnotes();
    super.initState();
  }

  Future<void> getnotes() async {
    await NotesController.getAllNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          customBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: NotesController.notes.length,
        itemBuilder:
            (context, index) => NoteCard(
              note: NotesController.notes[index],
              onEdit: () {
                //update note sheet
                customBottomSheet(
                  context,
                  isEdit: true,
                  note: NotesController.notes[index],
                );
              },
              onDelete: () async {
                await NotesController.deleteNote(
                  NotesController.notes[index].id,
                );
                setState(() {});
              },
            ),

        separatorBuilder: (context, index) => SizedBox(height: 16),
      ),
    );
  }

  Future<dynamic> customBottomSheet(
    BuildContext context, {
    bool isEdit = false,
    NoteModel? note,
  }) {
    TextEditingController titleC = TextEditingController();
    TextEditingController descC = TextEditingController();
    TextEditingController dateC = TextEditingController();

    if (isEdit) {
      titleC.text = note!.title;
      descC.text = note.description;
      dateC.text = note.date;
    }

    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.black,
      context: context,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16,
              children: [
                Text(
                  isEdit ? "Update Note" : "Add note",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                TextField(
                  controller: titleC,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Title",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextField(
                  controller: descC,
                  maxLines: 3,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Description",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                TextField(
                  controller: dateC,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Date",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                Row(
                  spacing: 8,
                  children: List.generate(
                    5,
                    (index) => Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,

                          borderRadius: BorderRadius.circular(12),
                        ),
                        height: 70,
                      ),
                    ),
                  ),
                ),

                ElevatedButton(onPressed: () {}, child: Text("CANCEL")),
                ElevatedButton(
                  onPressed: () async {
                    if (titleC.text.isNotEmpty &&
                        descC.text.isNotEmpty &&
                        dateC.text.isNotEmpty) {
                      if (isEdit) {
                        await NotesController.updateNote(
                          id: note!.id,
                          title: titleC.text.toString(),
                          des: descC.text.toString(),
                          date: dateC.text.toString(),
                        );
                      } else {
                        await NotesController.addNote(
                          title: titleC.text.toString(),
                          description: descC.text.toString(),
                          date: dateC.text.toString(),
                        );
                      }

                      Navigator.pop(context);
                      setState(() {});
                    } else {
                      print("Enter all fields");
                    }
                  },
                  child: Text(isEdit ? "Update" : "SAVE"),
                ),
              ],
            ),
          ),
    );
  }
}
