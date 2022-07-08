import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'accountModel.dart';

class AccountDatabase{
  static final AccountDatabase instance = AccountDatabase._init();

  static Database? _database;

  AccountDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('account.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableAccount(
      ${AccountFields.id} $idType,
      ${AccountFields.email} $textType,
      ${AccountFields.password} $textType,
      ${AccountFields.username} $textType
    )
    ''');
    debugPrint('berhasil');
  }

  Future<Account> create(Account account) async{
    final db = await instance.database;

    final id = await db.insert(tableAccount, account.toJson());
    return account.copy(id: id);
  }

  Future<Account> readData(int id) async{
    final db = await instance.database;

    final maps = await db.query(
      tableAccount,
      columns: AccountFields.values,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );

    if(maps.isNotEmpty){
      return Account.fromJson(maps.first);
    }else{
      throw Exception('ID $id not found');
    }
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tableAccount'));
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(tableAccount);
  }

  Future getID (String email)async{
    final db = await instance.database;
    return await db.rawQuery('SELECT id FROM $tableAccount WHERE email = "$email"', null);
  }

  Future getIDbyPass(String password) async {
    final db = await instance.database;
    return await db.rawQuery('SELECT id FROM $tableAccount WHERE password = "$password"', null);
  }

  Future getAccount(int id)async{
    final db = await instance.database;
    return await db.rawQuery('''SELECT * FROM $tableAccount WHERE id = "$id"''', null);
  }

  Future<Account> readDataEmail(String email) async{
    final db = await instance.database;

    final maps = await db.query(
      tableAccount,
      columns: AccountFields.values,
      where: '${AccountFields.email} = ?',
      whereArgs: [email],
    );

    if(maps.isNotEmpty){
      return Account.fromJson(maps.first);
    }else{
      throw Exception('Email $email not found');
    }
  }

  Future<Account> readDataPassword(String password) async{
    final db = await instance.database;

    final maps = await db.query(
      tableAccount,
      columns: AccountFields.values,
      where: '${AccountFields.password} = ?',
      whereArgs: [password],
    );


    if(maps.isNotEmpty){
      return Account.fromJson(maps.first);
    }else{
      throw Exception('ID $password not found');
    }
  }

  Future<List<Account>> readAllData() async{
    final db = await instance.database;

    final result = await db.query(tableAccount);
    return result.map((json) => Account.fromJson(json)).toList();
  }

  Future<int> update(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update(
      tableAccount,
      row,
      where: '"id" = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete (int id) async{
    final db = await instance.database;

    return await db.delete(
      tableAccount,
      where: '${AccountFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async{
    final db = await instance.database;

    db.close();
  }
}