import 'package:sqflite/sqflite.dart';
import 'package:tasksqflite/core/data/models/pegawai.dart';

class DbHelper {
  Database db;
  static final DbHelper _singleton = DbHelper._internal();

  factory DbHelper() {
    return _singleton;
  }

  DbHelper._internal() {
    openDb();
  }
  static final DbHelper instance = DbHelper();

  static const COLLUMN_POSITION = "jabatan";

  static const COLLUMN_DIVISION = "divisi";

  static const COLLUMN_ADDRESS = "alamat";

  static const COLLUMN_GENDER = "gender";

  static const COLLUMN_NAME = "nama";

  static const COLLUMN_ID = "id";

  static const TABLE_PEGAWAI_NAME = "tablepegawai";

  static const TABLE_LOGIN_NAME = "tableSlogin";

  static const COLLUMN_EMAIL = "email";

  static const COLLUMN_PASSWORD = "password";

  static const COLLUMN_PHONE = "phone";

  static const COLLUMN_ID_PEGAWAI = "idPegawai";

  Future openDb() async {
    if (db == null) {
      var dbPath = await getDatabasesPath();
      db = await openDatabase((dbPath + "mhs.db"), version: 1,
          onCreate: (db, version) async {
        db.execute('''
              CREATE table $TABLE_PEGAWAI_NAME (
                     $COLLUMN_ID_PEGAWAI integer primary key autoincrement,
                      $COLLUMN_NAME text ,
                      $COLLUMN_GENDER text ,
                      $COLLUMN_ADDRESS text,
                      $COLLUMN_POSITION text,
                      $COLLUMN_EMAIL text ,
                      $COLLUMN_PHONE integer ,

                      $COLLUMN_DIVISION text
                       )
                       ''');
        db.execute('''
                       CREATE table $TABLE_LOGIN_NAME (
                      $COLLUMN_ID integer primary key autoincrement,
                      $COLLUMN_EMAIL text not null,
                      $COLLUMN_PASSWORD text not null
                       )
                       ''');
      });
    }
  }

  Future<bool> login(String email, String password) async {
    List<Map<String, dynamic>> listUsr = (await db.rawQuery('''
                       SELECT * from $TABLE_LOGIN_NAME
                        where $COLLUMN_PASSWORD=\'$password\' AND
                         $COLLUMN_EMAIL=\'$email\' 
                         ''')) ?? [];
    if (listUsr.length > 0) {
      return listUsr.isNotEmpty;
    }
    return null;
  }

  Future<int> register(String email, String password) async {
    await openDb();

    return await db.insert(
        TABLE_LOGIN_NAME, {COLLUMN_EMAIL: email, COLLUMN_PASSWORD: password});
  }

  Future<List<Pegawai>> getListPegawai() async {
    await openDb();
    List<Pegawai> list = [];
    List<Map<String, dynamic>> maps =
        (await db.query(TABLE_PEGAWAI_NAME)) ?? [];
    if (maps.length > 0) {
      maps.forEach((element) {
        list.add(Pegawai.fromJson(element));
      });
    }
    return list;
  }

  Future<Pegawai> getDetailPegawai(int id) async {
    openDb();

    List<Map<String, dynamic>> maps = await db.rawQuery(
        'SELECT * FROM $TABLE_PEGAWAI_NAME WHERE $COLLUMN_ID_PEGAWAI = $id');
    if (maps.length > 0) {
      return Pegawai.fromJson(maps.first);
    }
    return null;
  }

  Future<bool> deletePegawai(int id) async {
    await openDb();

    int result = await db.delete(TABLE_PEGAWAI_NAME,
        where: '$COLLUMN_ID_PEGAWAI = ?', whereArgs: [id]);

    return result > 0;
  }

  Future<int> insert(Pegawai mhs) async {
    await openDb();

    return await db.insert(TABLE_PEGAWAI_NAME, mhs.toJson());
  }

  Future<int> update(Pegawai mhs) async {
    var json = mhs.toJson();
    json['idPegawai'] = null;
    json.removeWhere((key, value) => value == null);
    return await db.update(
        TABLE_PEGAWAI_NAME,
        json.map<String, Object>(
            (key, value) => MapEntry<String, Object>(key, value)),
        where: '$COLLUMN_ID_PEGAWAI = ?',
        whereArgs: [mhs.idPegawai]);
  }

  Future close() async {
    await openDb();
    db.close();
  }
}
