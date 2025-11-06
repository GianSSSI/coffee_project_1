import 'package:coffee/features/index/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/index/model/exceptions/sql_exception.dart';
import 'package:coffee/helpers/configuration/app_config.dart';
import 'package:coffee/services/database/app_database.dart';
import 'package:sqflite/sqlite_api.dart';

class CoffeeDao {
  final AppDatabase _appDatabase;

  CoffeeDao({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  Future<int> insertCoffee(LocalCoffee coffee) async {
    try {
      final db = await _appDatabase.database;
      return await db.insert(
        AppConfig.tbName,
        coffee.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } on DatabaseException catch (e) {
      throw SqlException(message: 'Database error: ${e.toString()}');
    } catch (e) {
      throw SqlException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  Future<List<LocalCoffee>> getAllCoffee() async {
    try {
      final db = await _appDatabase.database;
      final result = await db.query(AppConfig.tbName);
      return result.map((e) => LocalCoffee.fromJson(e)).toList();
    } on DatabaseException catch (e) {
      throw SqlException(message: 'Database error: ${e.toString()}');
    } catch (e) {
      throw SqlException(message: 'Unexpected error: ${e.toString()}');
    }
  }
}
