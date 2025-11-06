import 'package:coffee/helpers/configuration/app_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(AppConfig.dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    await deleteDatabase(dbPath);
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: AppConfig.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute("""
  CREATE TABLE ${AppConfig.tbName} (
    coffeeId INTEGER PRIMARY KEY,
    title TEXT,
    description TEXT,
    image TEXT,
    ingredients TEXT,
    label TEXT
  )
""");
  }
}
