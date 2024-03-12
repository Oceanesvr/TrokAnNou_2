import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../JSON/usager.dart';

class DatabaseHelper {
  final String databaseName = "trok_an_nou.db";

  final String usagersTable = '''
    CREATE TABLE usagers(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nom TEXT,
      prenom TEXT,
      user TEXT UNIQUE,
      tel TEXT,
      mail TEXT,
      mdp TEXT,
      type TEXT
    )
  ''';

  Future<void> copyDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, databaseName);

    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) {
      ByteData data = await rootBundle.load(join("assets", "trok_an_nou.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(usagersTable);
    });
  }

//Methode pour authentifier un utilisateur
  Future<bool> authenticate(String user, String mdp) async {
    final Database db = await initDB();
    var result = await db.rawQuery(
        "SELECT * FROM usagers WHERE user = ? AND mdp = ?", [user, mdp]);
    return result.isNotEmpty;
  }
//Methode pour inserer un nouvel utilisateur dans la table des usagers
  Future<int> createUser(Usagers usr) async {
    final Database db = await initDB();
    return db.insert("usagers", usr.toMap());
  }

//Methode qui récupère les informations d'un utilisateur à partir de son nom d'utilisateur
  Future<Usagers?> getUser(String usrName) async {
    final Database db = await initDB();
    var res =
        await db.query("usagers", where: "user = ?", whereArgs: [usrName]);
    return res.isNotEmpty ? Usagers.fromMap(res.first) : null;
  }
}
