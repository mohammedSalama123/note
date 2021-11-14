import 'package:flutter_app/model/notes_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper.internal();

  static Database? db;

  Future<Database?> createDatabase() async {
    if (db != null) {
      return db;
    }
    String path = join(await getDatabasesPath(), 'todo.db');
   db=await openDatabase(path, version: 1, onCreate:initDB);
   return db;
  }
  ///function create
   initDB(Database db, int version) async {
     ///create tables
     await db.execute('create table todo(id integer primary key autoincrement,title text,content text,dateTime text)');
   }

  Future<int?> createTodo(NotesModel note) async {
    Database? db=await createDatabase();
   return  db?.insert('todo', note.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
   }

  Future<List?> allTodo()async{
    Database? db=await createDatabase();
   return db?.query('todo');
  }
 Future<int?> delete(int id)async{
   Database? db=await createDatabase();
   int? count= await  db?.delete('todo',where: 'id = ?',whereArgs: [id]);
    return count;
  }

 Future<int?> update(NotesModel note)async{
    Database? db=await createDatabase();
 return await  db?.update('todo', note.toMap(),where: 'id = ?',whereArgs: [note.id]);
  }


}
