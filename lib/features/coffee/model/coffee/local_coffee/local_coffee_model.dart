import 'dart:convert';
import 'package:coffee/features/coffee/model/coffee/remote_coffee/remote_coffee_model.dart';
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

  factory LocalCoffee.fromJson(Map<String, dynamic> json) =>
      _$LocalCoffeeFromJson(json);

  Map<String, dynamic> toJson() => _$LocalCoffeeToJson(this);
  static List<String> _ingredientsFromJson(dynamic value) {
    if (value == null) return [];

    if (value is List) {
      return value.map((e) => e.toString()).toList();
    } else if (value is String) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is List) {
          return decoded.map((e) => e.toString()).toList();
        }
      } catch (_) {
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
