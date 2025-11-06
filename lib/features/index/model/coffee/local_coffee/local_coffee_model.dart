import 'dart:convert';
import 'package:coffee/features/index/model/coffee/remote_coffee_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_coffee_model.g.dart';

@JsonSerializable()
class LocalCoffee {
  final int coffeeId;
  final String title;
  final String description;
  final String image;

  @JsonKey(fromJson: _ingredientsFromJson, toJson: _ingredientsToJson)
  final List<String> ingredients;

  final String label;

  LocalCoffee({
    required this.coffeeId,
    required this.title,
    required this.description,
    required this.image,
    required this.ingredients,
    required this.label,
  });

  // -------------------- FACTORIES --------------------

  factory LocalCoffee.fromJson(Map<String, dynamic> json) =>
      _$LocalCoffeeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalCoffeeToJson(this);

  factory LocalCoffee.fromRemote(RemoteCoffee remote, {String label = ''}) {
    return LocalCoffee(
      coffeeId: int.tryParse(remote.id) ?? 0,
      title: remote.title,
      description: remote.description,
      image: remote.image,
      ingredients: remote.ingredients,
      label: label,
    );
  }

  // -------------------- CUSTOM CONVERTERS --------------------

  static List<String> _ingredientsFromJson(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      // Already a list (normal case)
      return value.map((e) => e.toString()).toList();
    } else if (value is String) {
      // Stored as a JSON string (from SQLite)
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {
        // Fallback if it’s comma-separated
        return value.split(',').map((e) => e.trim()).toList();
      }
    }

    return [];
  }

  static dynamic _ingredientsToJson(List<String> ingredients) =>
      jsonEncode(ingredients);

  factory LocalCoffee.fromRemoteCoffee(
    RemoteCoffee remoteCoffee, {
    String label = '',
  }) {
    return LocalCoffee(
      coffeeId: int.tryParse(remoteCoffee.id) ?? 0,
      title: remoteCoffee.title,
      description: remoteCoffee.description,
      image: remoteCoffee.image,
      ingredients: remoteCoffee.ingredients,
      label: label,
    );
  }
}
