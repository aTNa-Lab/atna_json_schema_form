import 'package:json_annotation/json_annotation.dart';

import '../models/array.dart';
import '../models/field.dart';
import '../models/section.dart';
import '../models/text_field.dart';
import 'types.dart';

class Utilities {
  static List<Field> mapJsonToFields(Map<String, dynamic> json, Map<String, dynamic>? ui) {
    Map<String, dynamic> fieldMap = json;
    List<Field> fields = [];
    for (var field in fieldMap.entries) {
      Map<String, dynamic> lui = ui != null ? ui[field.key] ?? {} : {};
      fields.add(createModelFromSchema(field.key, field.value, lui));
    }
    return fields;
  }

  static Field createModelFromSchema(String id, Map<String, dynamic> schema, Map<String, dynamic> ui) {
    final field = schema;
    final type = field['type'];
    if (type == 'string') {
      return TextFieldModel(
        id: id,
        title: field['title'],
        description: field['description'],
        fieldType: $enumDecodeNullable(typeEnumMap, type),
        widgetType: $enumDecodeNullable(widgetEnumMap, ui['ui:widget']),
        enumOptions: field['enum'],
        enumNames: field['enumNames'],
      );
    } else if (type == 'array') {
      final array = field['items'];
      if (array is List) {
        final fields = array.mapWithIndex((e, index) {
          final field = e as Map<String, dynamic>;
          return createModelFromSchema(index.toString(), field, ui[index] ?? {});
        }).toList();
        return Array(id: id, isFixed: true, items: fields);
      } else if (array is Map<String, dynamic>) {
        final itemType = createModelFromSchema('1', array, ui);
        return Array(id: id, isFixed: false, itemType: itemType);
      } else {
        throw Exception('Incorrect type of items in $id');
      }
    } else {
      return Section(id: id, fields: mapJsonToFields(field['properties'], ui));
    }
  }
}

extension on Iterable {
  Iterable<T> mapWithIndex<T, E>(T Function(E e, int i) toElement) sync* {
    int index = 0;
    for (var value in this) {
      yield toElement(value, index);
      index++;
    }
  }
}
