import 'package:flutter/material.dart';
import 'package:my_note_app/note_controller/note_controller.dart';
import 'package:my_note_app/screen/home_screen.dart';
import 'package:my_note_app/screen/update_note_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => NoteController(),
          child: HomeScreen(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
