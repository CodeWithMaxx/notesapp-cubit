import 'dart:async';
import 'dart:io';

import 'package:notebook/Model/notesmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper myDb = DbHelper._();
  Database? _database;
  static const note_table = "notetable";
  static const note_id = "noteid";
  static const note_title = "notetitle";
  static const note_desc = "notedesc";

  Future<Database> getDb() async {
    if (_database != null) {
      return _database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    var dbpath = join(directory.path + "notedb.db");
    return await openDatabase(dbpath, version: 1, onCreate: (db, version) {
      return db.execute(
          "Create table $note_table ( $note_id integer primary key autoincrement , $note_title text ,$note_desc text)");
    });
  }

  inserallnotes(NotesModel notesModel) async {
    var db = await myDb.getDb();
    await db.insert(note_table, notesModel.toMap());
  }

  Future<List<NotesModel>> getData() async {
    var db = await myDb.getDb();
    List<NotesModel> noteList = [];
    var data = await db.query(note_table);
    for (Map<String, dynamic> eachData in data) {
      NotesModel notesModel = NotesModel.formMap(eachData);
      noteList.add(notesModel);
    }
    return noteList;
  }

  Future<bool> deletenotes(int nid) async {
    var db = await myDb.getDb();
    var count =
        await db.delete(note_table, where: "$note_id =?", whereArgs: [nid]);
    return count > 0;
  }

  Future<bool> updatenotes(NotesModel notes) async {
    var db = await myDb.getDb();
    var count = await db.update(note_table, notes.toMap(),
        where: "$note_id=${notes.id}");
    return count > 0;
  }
}
