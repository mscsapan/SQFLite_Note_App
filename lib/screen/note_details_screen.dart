import 'package:flutter/material.dart';
import 'package:my_note_app/database/database_helper.dart';
import 'package:my_note_app/model/model.dart';
import 'package:my_note_app/note_controller/note_controller.dart';
import 'package:my_note_app/route.dart';
import 'package:my_note_app/screen/update_note_screen.dart';
import 'package:provider/provider.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteController = Provider.of<NoteController>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Note Details'), centerTitle: true),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
        child: FutureBuilder<List<Note>>(
          future: noteController.getInsertedNote(),
          builder: (context, AsyncSnapshot<List<Note>> snapshot) {
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('Empty Note'));
            } else {
              return snapshot.hasData
                  ? GridView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, position) {
                        final Note note = snapshot.data![position];
                        return Container(
                            height: 200.0,
                            width: MediaQuery.of(context).size.width / 2.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 120.0,
                                        height: 40.0,
                                        child: Text(
                                          note.title,
                                          style:
                                              const TextStyle(fontSize: 17.0),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      PopupMenuButton(
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    onTap: () {
                                                      goToNext(
                                                          context: context,
                                                          screen: UpdateNoteScreen(
                                                              title: note.title,
                                                              description: note
                                                                  .description));
                                                      debugPrint('Clicked...');
                                                    },
                                                    child:
                                                        const Text('Update')),
                                                PopupMenuItem(
                                                    onTap: () async {
                                                      await NoteDBHelper
                                                          .noteHelper
                                                          .deleteNote(note.id!)
                                                          .then((val) {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(SnackBar(
                                                                content: Text(
                                                                    '$position id is Deleted')));
                                                      });
                                                    },
                                                    child:
                                                        const Text('Delete')),
                                              ])
                                    ],
                                  ),
                                  const SizedBox(height: 5.0),
                                  Text(note.description),
                                ],
                              ),
                            ));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 0.0),
                    )
                  : const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
