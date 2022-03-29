import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:resumemaker/model.dart';

class cvsDatabase {
  static final cvsDatabase instance = cvsDatabase._init();

  static Database? _database;

  cvsDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
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
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $cvtable ( 
  ${cvsFields.id} $idType, 
  ${cvsFields.liked} $boolType,
  ${cvsFields.mnumber} $integerType,
  ${cvsFields.title} $textType,
  ${cvsFields.fullname} $textType,
  ${cvsFields.address} $textType,
  ${cvsFields.skills} $textType,
  ${cvsFields.edu} $textType,
  ${cvsFields.time} $textType
  )
''');
  }

  Future<cv> create(cv cvs) async {
    final db = await instance.database;

    final id = await db.insert(cvtable, cvs.toJson());
    return cvs.copy(id: id);
  }

  Future<cv> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      cvtable,
      columns: cvsFields.values,
      where: '${cvsFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return cv.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<cv>> readAllcvs() async {
    final db = await instance.database;

    final orderBy = '${cvsFields.time} ASC';
   

    final result = await db.query(cvtable, orderBy: orderBy);

    return result.map((json) => cv.fromJson(json)).toList();
  }

  Future<int> update(cv cvs) async {
    final db = await instance.database;

    return db.update(
      cvtable,
      cvs.toJson(),
      where: '${cvsFields.id} = ?',
      whereArgs: [cvs.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      cvtable,
      where: '${cvsFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}