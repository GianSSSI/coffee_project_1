import 'package:flutter/services.dart';
import 'package:xml/xml.dart';

class XmlQueryLoader {
  static final Map<String, String> _queries = {};

  static Future<void> loadQueries() async {
    if (_queries.isNotEmpty) return;
    final xmlString = await rootBundle.loadString('assets/xml/queries.xml');
    final document = XmlDocument.parse(xmlString);

    for (final query in document.findAllElements('query')) {
      final id = query.getAttribute('id');
      final sql = query.innerText.trim();
      if (id != null) _queries[id] = sql;
    }
  }

  static String get(String id) {
    final query = _queries[id];
    if (query == null) {
      throw Exception('Query "$id" not found in XML.');
    }
    return query;
  }
}
