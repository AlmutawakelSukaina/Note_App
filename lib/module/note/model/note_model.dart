

import '../../../libs.dart';

class Note {

  final String title;
  final String content;
  final int isPinned;
  final int? createdTime;
  final String? reminderTime;
  final int? archive;
  final int? id;


  Note( {
    this.id,
    required this.title,
    required this.content,
    this.isPinned=0,
    this.createdTime,
    this.reminderTime,
    this.archive,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    id:json[NoteFields.id],
    title: json[NoteFields.title],
    content: json[NoteFields.content],
    isPinned: json[NoteFields.isPined],
    createdTime:    DateTime.now().millisecondsSinceEpoch,
    reminderTime: json[NoteFields.reminderTime],
    archive: json[NoteFields.archive]??0,
  );

  Map<String, dynamic> toJson() => {
    if(id!=null)
    NoteFields.id:id,
    NoteFields.title: title,
    NoteFields.content: content,
    NoteFields.isPined: isPinned,
    NoteFields.createdTime: DateTime.now().millisecondsSinceEpoch,
    NoteFields.reminderTime: reminderTime,
    NoteFields.archive: archive??0,

  };
}