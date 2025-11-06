// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_coffee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCoffee _$LocalCoffeeFromJson(Map<String, dynamic> json) => LocalCoffee(
  coffeeId: (json['coffeeId'] as num).toInt(),
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  ingredients: (json['ingredients'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  label: json['label'] as String,
);

Map<String, dynamic> _$LocalCoffeeToJson(LocalCoffee instance) =>
    <String, dynamic>{
      'coffeeId': instance.coffeeId,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'ingredients': instance.ingredients,
      'label': instance.label,
    };
