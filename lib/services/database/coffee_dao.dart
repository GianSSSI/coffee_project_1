import 'dart:convert';

import 'package:coffee/features/coffee/model/coffee/local_coffee/local_coffee_model.dart';
import 'package:coffee/features/coffee/model/exceptions/sql_exception.dart';
import 'package:coffee/core/configuration/app_config.dart';
import 'package:coffee/helpers/xml_query/query_loader.dart';
import 'package:coffee/services/database/app_database.dart';
import 'package:sqflite/sqlite_api.dart';

class CoffeeDao {
  final AppDatabase _appDatabase;

  CoffeeDao({required AppDatabase appDatabase}) : _appDatabase = appDatabase;

  Future<int> insertCoffeeViaXml(LocalCoffee coffee) async {
    try {
      await XmlQueryLoader.loadQueries();
      final db = await _appDatabase.database;
      final sqlInsert = XmlQueryLoader.get('insert_coffee');
      final sqlFetch = XmlQueryLoader.get('get_coffee_by_id');

      final existing = await db.rawQuery(sqlFetch, [coffee.coffeeId]);

      if (existing.isEmpty) {
        final coffeeId = await db.rawInsert(sqlInsert, [
          coffee.coffeeId,
          coffee.title,
          coffee.description,
          coffee.image,
          jsonEncode(coffee.ingredients),
          coffee.label,
        ]);
        return coffeeId;
      } else {
        throw SqlException(message: "Coffee Already Saved");
      }
    } on SqlException catch (_) {
      rethrow;
    } on DatabaseException catch (e) {
      throw SqlException(message: 'Database error: ${e.toString()}');
    } catch (e) {
      throw SqlException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  Future<List<LocalCoffee>> getAllCoffeeViaXml() async {
    try {
      await XmlQueryLoader.loadQueries();
      final db = await _appDatabase.database;
      final sql = XmlQueryLoader.get('get_all_coffee');

      final result = await db.rawQuery(sql);
      return result.map((row) {
        return LocalCoffee.fromJson(row);
      }).toList();
    } on DatabaseException catch (e) {
      throw SqlException(message: 'Database error: ${e.toString()}');
    } catch (e) {
      throw SqlException(message: 'Unexpected error: ${e.toString()}');
    }
  }

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
