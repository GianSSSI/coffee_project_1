import 'package:json_annotation/json_annotation.dart';

part 'coffee_model.g.dart';

@JsonSerializable()
class Coffee {
  final String title;
  final String description;
  final String image;

  @JsonKey(fromJson: _idFromJson, toJson: _idToJson)
  final String id;

  @JsonKey(fromJson: _ingredientsFromJson, toJson: _ingredientsToJson)
  final List<String> ingredients;

  Coffee({
    required this.title,
    required this.description,
    required this.image,
    required this.id,
    required this.ingredients,
  });

  factory Coffee.fromJson(Map<String, dynamic> json) => _$CoffeeFromJson(json);
  Map<String, dynamic> toJson() => _$CoffeeToJson(this);

  static String _idFromJson(dynamic id) => id.toString();
  static dynamic _idToJson(String id) => id;

  static List<String> _ingredientsFromJson(dynamic value) {
    if (value is List) {
      return value.map((e) => e.toString()).toList();
    } else if (value is String) {
      return value
          .replaceAll('[', '')
          .replaceAll(']', '')
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
    } else {
      return [];
    }
  }

  static dynamic _ingredientsToJson(List<String> ingredients) => ingredients;
}
