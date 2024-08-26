import 'dart:io';

import 'package:path/path.dart' as p;

// import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../libs.dart';

class NoteDatabase {
  static final NoteDatabase instance = NoteDatabase._internal();

  static Database? _database;

  NoteDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = "$databasePath/my_database.db";

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, _) async {
    await db.execute('''
        CREATE TABLE ${NoteFields.tableName} (
          ${NoteFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
         
          ${NoteFields.title} TEXT,
          ${NoteFields.content} TEXT,
          ${NoteFields.isPined} INTEGER,
          ${NoteFields.createdTime}  INTEGER,
          ${NoteFields.reminderTime}  TEXT,
                 ${NoteFields.archive} INTEGER
        )
      ''');

    await db.execute('''
        CREATE TABLE ${TageTable.tableName} (
          ${TageTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
         
          ${TageTable.noteId} INTEGER,
          ${TageTable.tag} TEXT 
        )
      ''');
  }

  Future<List<Map<String, dynamic>>> getAllTags() async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT DISTINCT  ${TageTable.tag} "
        "FROM ${TageTable.tableName}  ");

    return result;
  }

  Future<List<String>> getTagsByNoteId(int id) async {
    final db = await instance.database;
    final result = await db.rawQuery("SELECT DISTINCT  ${TageTable.tag} "
        "FROM ${TageTable.tableName}  "
        "WHERE ${TageTable.noteId}=$id  ");

    return result.map((e) => e[TageTable.tag].toString()).toList();
  }

  Future<List<Map<String, dynamic>>> getNotesByTag(String tag) async {
    final db = await instance.database;
    final result = await db.rawQuery('''
      SELECT DISTINCT ${NoteFields.tableName}.${NoteFields.id}  ,
       ${NoteFields.tableName}.${NoteFields.content},
        ${NoteFields.tableName}.${NoteFields.title},
         ${NoteFields.tableName}.${NoteFields.isPined},
          ${NoteFields.tableName}.${NoteFields.archive},
           ${NoteFields.tableName}.${NoteFields.reminderTime}          
      FROM ${NoteFields.tableName}  
      JOIN ${TageTable.tableName}  
       ON ${TageTable.tableName}.${TageTable.noteId} =${NoteFields.tableName}.${NoteFields.id}  
      WHERE ${TageTable.tableName}.${TageTable.tag} =\'$tag'\
    ''');
    return result;
  }

  Future<int> insertNote(Note note) async {
    final db = await instance.database;
    final insertedId = await db.insert(NoteFields.tableName, note.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return insertedId;
  }

  Future<void> insertTags(List<String> tags, int noteId) async {
    final db = await instance.database;
    final batch = db.batch();
    for (final tag in tags) {
      batch.insert(
          TageTable.tableName, {TageTable.noteId: noteId, TageTable.tag: tag},
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
  }

  Future<void> insertNoteWithTags(Note note, List<String> tags) async {
    final insertedId = await insertNote(note);
    if (insertedId > 0) {
      await insertTags(tags, insertedId);
    }
  }

  Future<int> deleteNote(int id) async {
    final db = await instance.database;
    final result = await db.delete(
      NoteFields.tableName,
      where: '${NoteFields.id} = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateNote(Note note) async {
    final db = await instance.database;
    final result = await db.update(
      NoteFields.tableName,
      note.toJson(),
      where: '${NoteFields.id} = ?',
      whereArgs: [note.id],
    );
    return result;
  }

  Future<int> deleteTagsByNoteIdAndTags(int noteId, List<String> tags) async {
    final db = await instance.database;
    return db.delete("  ${TageTable.tableName} "

        " WHERE  ${TageTable.noteId}=$noteId "
        " AND  ${TageTable.tag} IN (${tags.map((e) =>"'$e'").toList().join(",")}) ");
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
