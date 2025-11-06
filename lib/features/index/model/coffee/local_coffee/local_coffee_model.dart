import 'package:coffee/features/index/model/coffee/remote_coffee_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'local_coffee_model.g.dart';

@JsonSerializable()
class LocalCoffee {
  final int coffeeId;
  final String title;
  final String description;
  final String image;
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
