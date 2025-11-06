// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_coffee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteCoffee _$RemoteCoffeeFromJson(Map<String, dynamic> json) => RemoteCoffee(
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  id: RemoteCoffee._idFromJson(json['id']),
  ingredients: RemoteCoffee._ingredientsFromJson(json['ingredients']),
);

Map<String, dynamic> _$RemoteCoffeeToJson(RemoteCoffee instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'id': RemoteCoffee._idToJson(instance.id),
      'ingredients': RemoteCoffee._ingredientsToJson(instance.ingredients),
    };
