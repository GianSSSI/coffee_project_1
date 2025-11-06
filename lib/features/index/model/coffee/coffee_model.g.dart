// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coffee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Coffee _$CoffeeFromJson(Map<String, dynamic> json) => Coffee(
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  id: Coffee._idFromJson(json['id']),
  ingredients: Coffee._ingredientsFromJson(json['ingredients']),
);

Map<String, dynamic> _$CoffeeToJson(Coffee instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'image': instance.image,
  'id': Coffee._idToJson(instance.id),
  'ingredients': Coffee._ingredientsToJson(instance.ingredients),
};
