import 'package:my_notepad/local_database/initialize_database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Connection {
  static late Database _database;
  static bool _fechado = true;

  static Future<Database> create() async {
    if(_fechado) {
      String path = join(await getDatabasesPath(), 'banco.db');
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (db, v) {
          db.execute(InitializeBd.createTableNotepad);
          for (var element in InitializeBd.insertNotepads) {
            db.execute(element);
          }
        },
      );
      _fechado = false;
    }
    return _database;
  }
}