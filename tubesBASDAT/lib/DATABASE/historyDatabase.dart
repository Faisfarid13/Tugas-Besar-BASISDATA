import 'package:flutter/foundation.dart';
import 'package:modul_2/DATABASE/accountModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'historyModel.dart';

class HistoryDatabase{
  static final HistoryDatabase instance = HistoryDatabase._init();

  static Database? _database;

  HistoryDatabase._init();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await _initDB('history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableHistory(
      ${HistoryFields.id} $idType,
      ${HistoryFields.link} $textType
    )
    ''');
    debugPrint('berhasil');
  }

  Future<History> create (History history) async {
    final db = await instance.database;

    final id = await db.insert(tableHistory, history.toJson());
    print(('berhasil add data'));
    return history.copy(id: id);
  }

  Future<List<Map<String, dynamic>>> getHistory() async{
    final db = await instance.database;
    return db.query(tableHistory);
  }

}