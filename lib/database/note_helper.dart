import 'dart:io';

import 'package:note_app/model/note.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class NoteHelper {
  final String tableName = "userTable";
  final String columnId = "id";
  final String columnTitle = "title";
  final String columnNotes = "content";

  static final NoteHelper _instance = NoteHelper.internal();
  factory NoteHelper() => _instance;

  static Database _db;
  Future<Database> get db async{
    if(_db != null){

      return _db;
    }
    _db = await initDb();

    return _db;
  }

  NoteHelper.internal();

  initDb() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "userdb.db");

    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate,);
    return ourDb;
  }

  void _onCreate(Database db, int newVersion) async{
    await db.execute(
        "CREATE TABLE IF NOT EXISTS $tableName("
            "$columnId INTEGER PRIMARY KEY, "
            "$columnTitle TEXT, "
            "$columnNotes TEXT "
            ")"
    );
  }


  //Insertion
  Future<int> saveNote(Note note) async{
    var dbClient = await db;
    int res = await dbClient.insert("$tableName",  note.toMap());
    return res;
  }

  //Get Notes
  Future<List> getNotes() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnId DESC");
    return res.toList();
  }

  // Get Count
  Future<int> getCount() async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName");
    return Sqflite.firstIntValue(res);
  }

  // Get one Note with Note ID
  Future<Note> getNote(int id) async{
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE $columnId = $id");

    if(res.length == 0 || res.length > 1){
      return null;
    }

    return Note.fromMap(res.first);
  }

  //Delete a Note
  Future<int> deleteNote(int id) async{
    var dbClient = await db;
    return await dbClient.delete(
        tableName,
        where: "$columnId = ?",
        whereArgs: [id]
    );
  }

  //Update a Note
  Future<int> updateNote(Note note) async{
    var dbClient = await db;
    return await dbClient.update(
        tableName,
        note.toMap(),
        where: "$columnId = ?",
        whereArgs: [note.id]
    );
  }

  //Close the connection
  Future close() async{
    var dbClient = await db;
    return dbClient.close();
  }
}
