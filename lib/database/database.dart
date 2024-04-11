import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  Future<Database> initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String databasePath = join(appDocDir.path, 'exam.db');
    return await openDatabase(databasePath);
  }

  Future<bool> copyPasteAssetFileToRoot() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "exam.db");

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data =
      await rootBundle.load(join('assets/Database', 'exam.db'));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return true;
    }
    return false;
  }

  Future<List<Map<String,dynamic>>> getData() async {
    Database db = await initDatabase();
    List<Map<String,dynamic>> data = await db.rawQuery("select * from exam");
    return data;
  }

  Future<void> insertData(Map<String,dynamic> data) async {
    Database db = await initDatabase();
    await db.insert("exam", data);
    return;
  }

  Future<void> deleteData(int id) async {
    Database db = await initDatabase();
    await db.delete("exam",where: "id = ?",whereArgs: [id]);
    return;
  }

  Future<void> updateData(int id,Map<String,dynamic> data) async {
    Database db = await initDatabase();
    await db.update("exam",data,where: "id = ?",whereArgs: [id]);
    return;
  }
}