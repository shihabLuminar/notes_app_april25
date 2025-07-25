import 'package:flutter/material.dart';
import 'package:notes_app/controller/notes_controller.dart';
import 'package:notes_app/view/notes_screen/notes_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotesController.initializeDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyApp',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const NotesScreen(),
    );
  }
}
