class Note {
  final int? id;
  final String title;
  final String description;

  Note({this.id, required this.title, required this.description});

  Note.fromNote(Map<String, dynamic> fromNoteMap)
      : id = fromNoteMap['id'],
        title = fromNoteMap['title'],
        description = fromNoteMap['description'];

  Map<String, dynamic> toNoteMap() {
    return {'id': id, 'title': title, 'description': description};
  }
}
