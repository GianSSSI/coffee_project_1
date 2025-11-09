import 'package:coffee/core/configuration/app_config.dart';
import 'package:coffee/helpers/xml_query/query_loader.dart';
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

    final path = join(dbPath, filePath);
    await deleteDatabase(path);
    return await openDatabase(
      path,
      version: AppConfig.dbVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await XmlQueryLoader.loadQueries();
    final createTbQuery = XmlQueryLoader.get("create_coffee_table");
    await db.execute(createTbQuery);
  }
}
