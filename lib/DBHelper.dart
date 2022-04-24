// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:studentdb/student.dart';

class DBHelper {
  Future<Database> getDatabase() async {
    //Check any flutter upgrde changes
    WidgetsFlutterBinding.ensureInitialized();
    final database = openDatabase(
      // Open the database at a given path, and created it if this is first itme
      join(await getDatabasesPath(),
          'studentsgie_database.db'), // create a string
      onCreate: (db, version) {
        //is called if the database did not exist prior to calling [openDatabase].
        return db.execute(
            'CREATE TABLE studentss(' //Execute an SQL query with no return value.
            'id INTEGER PRIMARY KEY autoincrement,'
            'name TEXT,'
            'age INTEGER,'
            'city Text)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        //is called if either of the following conditions are met
        db.execute('DROP TABLE studentss');
        return db.execute('CREATE TABLE studentss('
            'id INTEGER PRIMARY KEY autoincrement,'
            'name TEXT,'
            'age INTEGER,'
            'city TEXT)');
      },
      version: 2,
    );
    return database;
  }

  Future<int> insertStudents(Students students) async {
    final db = await getDatabase();
    return await db.insert(
      //This method helps insert a map of [values] into the specified [table] and returns the id of the last inserted row
      'studentss',
      students.toMapWithoutId(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateStudents(Students students) async {
    final db = await getDatabase();
    return await db.update(
      //Convenience method for updating rows in the database. Returns the number of changes made
      'studentss',
      students.toMapWithoutId(),
      where: 'id = ?',
      whereArgs: [students.id],
    );
  }

  deleteStudents(int id) async {
    final db = await getDatabase();
    await db.delete(
      //Convenience method for deleting rows in the database.
      'studentss',
      where: 'id = ?',
      whereArgs: [id],
    );
    List<Students> allStudentss = await getAllStudentss();
    db.execute('DROP TABLE studentss');
    db.execute(
        'CREATE TABLE studentss(' //Execute an SQL query with no return value.
        'id INTEGER PRIMARY KEY autoincrement,'
        'name TEXT,'
        'age INTEGER,'
        'city Text)');
    for (var element in allStudentss) {
      insertStudents(element);
    }
  }

  Future<List<Students>> getAllStudentss() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> listOfStudentss =
        await db.query('studentss');
    return List.generate(listOfStudentss.length, (i) {
      return Students(
        listOfStudentss[i]['id'],
        listOfStudentss[i]['name'],
        listOfStudentss[i]['age'],
      );
    });
  }

  Future<List<Students>> getStudents(int id) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> listOfStudentss = await db.query(
      //This is a helper to query a table and return the items found. All optional clauses and filters are formatted as SQL queries excluding the clauses' names.
      'studentss',
      where: 'id = ?',
      whereArgs: [id],
    );
    return List.generate(listOfStudentss.length, (i) {
      return Students(
        listOfStudentss[i]['id'],
        listOfStudentss[i]['name'],
        listOfStudentss[i]['age'],
      );
    });
  }
}
