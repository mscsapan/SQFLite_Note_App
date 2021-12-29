import 'package:flutter/material.dart';
import 'package:my_note_app/database/database_helper.dart';
import 'package:my_note_app/model/model.dart';
import 'package:my_note_app/note_controller/note_controller.dart';
import 'package:my_note_app/screen/note_details_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  NoteDBHelper? helper;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Show'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider(
                    create: (context) => NoteController(),
                    child: const NoteDetailsScreen(),
                  ),
                ),
              );
            },
            child:
                const Text('Save Note', style: TextStyle(color: Colors.white)),
          )
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0)),
                    hintText: 'Title'),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: descriptionController,
                maxLines: 10,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    hintText: 'Description'),
              ),
              const SizedBox(height: 10.0),
              MaterialButton(
                color: Colors.green[900],
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                onPressed: () async {
                  await NoteDBHelper.noteHelper
                      .insertNote(
                    Note(
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  )
                      .then((value) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChangeNotifierProvider(
                          create: (context) => NoteController(),
                          child: const NoteDetailsScreen(),
                        ),
                      ),
                    );
                    debugPrint('Note Added Successfully');
                  });
                },
                child: const Text('Save Note',
                    style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
