import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_controller.dart';

import 'package:notes_app/model/note_model.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note, this.onDelete, this.onEdit});
  final NoteModel note;
  final void Function()? onDelete;
  final void Function()? onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  note.title,
                  maxLines: 2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),

              IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
              IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
            ],
          ),
          Text(note.description, style: TextStyle(fontSize: 12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: Text(note.date, maxLines: 1)),
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
            ],
          ),
        ],
      ),
    );
  }
}
