import 'package:my_notepad/dao/generic_dao.dart';
import 'package:my_notepad/local_database/connection.dart';
import 'package:my_notepad/model/notepad.dart';
import 'package:sqflite/sqflite.dart';

class NotepadDao extends GenericDao<Notepad, int> {
  @override
  Future<bool> delete(int id) async {
    Database db = await Connection.create();
    var sql = 'DELETE FROM notepad WHERE id = ?';
    int rowsDeleted = await db.rawDelete(sql, [id]);
    return rowsDeleted > 0;
  }

  @override
  Future<List<Notepad>> listAll() async {
    Database db = await Connection.create();
    List<Notepad> notepadList =
    (await db.query("notepad")).map<Notepad>(Notepad.fromJson).toList();
    return notepadList;
  }

  @override
  Future<Notepad> listById(int id) async {
    Database db = await Connection.create();
    List<Map> maps =
    await db.query('notepad', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) {
      throw Exception('Not found');
    }
    Map<dynamic, dynamic> result = maps.first;
    return Notepad.fromJson(result);
  }

  @override
  Future<Notepad> save(Notepad data) async {
    Database db = await Connection.create();
    String sql = 'INSERT INTO notepad (title, description) VALUES (?, ?)';
    int id = await db.rawInsert(sql, [data.title, data.description]);
    data = Notepad(id: id, title: data.title, description: data.description);
    return data;
  }

  @override
  Future<int> update(Notepad data) async {
    if (data.id == null) {
      throw Exception("Notepad not found");
    }
    Database db = await Connection.create();
    var sql = 'UPDATE notepad SET title = ?, description = ? WHERE id = ?';
    int id = await db.rawUpdate(sql, [data.title, data.description, data.id]);
    return id;
  }
}