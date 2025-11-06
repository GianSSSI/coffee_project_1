import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class StringListConverter implements JsonConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromJson(String json) {
    return List<String>.from(jsonDecode(json));
  }

  @override
  String toJson(List<String> object) {
    return jsonEncode(object);
  }
}
