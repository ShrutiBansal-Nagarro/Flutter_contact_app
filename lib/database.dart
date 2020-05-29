import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shruticontactapp/model/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ContactDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
        "CREATE TABLE ContactInfo(contactId INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, mobile TEXT, landline TEXT, isFavorite INTEGER)",
      );
    });
  }

  Future<void> insertContact(ContactModel contactModel) async {
    // Get a reference to the database.
    final Database db = await database;
    await db.insert(
      'ContactInfo',
      contactModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ContactModel>> contactList() async {
    // Get a reference to the database.
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('ContactInfo');

    return List.generate(maps.length, (i) {
      return ContactModel.fromMap(maps[i]);
    });
  }

  Future<void> updateContact(ContactModel contactModel) async {
    // Get a reference to the database.
    final db = await database;

    await db.update(
      'ContactInfo',
      contactModel.toMap(),
      where: "contactId = ?",
      whereArgs: [contactModel.contactModel.identifier],
    );
  }

  Future<void> deleteContact(int contactId) async {
    // Get a reference to the database.
    final db = await database;

    await db.delete(
      'ContactInfo',
      where: "contactId = ?",
      whereArgs: [contactId],
    );

    print(await contactList());
  }
}
