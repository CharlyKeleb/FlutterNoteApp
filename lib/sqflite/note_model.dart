import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

void main() async {
  final database = openDatabase(
    join(await getDatabasesPath(), 'notes_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT)",
      );
    },
    version: 1,
  );
  Future<void> insertNote(Note note) async {
    final Database db = await database;

    await db.insert(
      'note',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Note>> note() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('note');

    return List.generate(maps.length, (i) {
      return Note(
        maps[i]['id'],
        maps[i]['title'],
        maps[i]['notes'],
      );
    });
  }

  Future<void> updateNote(Note note) async {
    final db = await database;
    await db.update(
      'note',
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await database;

    await db.delete('note', where: "id = ?",
        whereArgs: [id]);
  }
   var work = Note(0, 'Activity', 'Here we come');
  await insertNote(work);
  print(await note());

  work = Note(work.id, work.title, work.notes);
  await updateNote(work);
  print(await note());
  await deleteNote(work.id);
  print(await note());
}

class Note {
  final int id;
  final String title;
  final String notes;

  Note(this.id, this.title, this.notes);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'notes': notes,
    };
  }
  String toString() {
    return 'Note{id: $id, name: $title, age: $notes}';
  }
}
