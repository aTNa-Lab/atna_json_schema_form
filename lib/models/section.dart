import 'package:json_annotation/json_annotation.dart';

import 'field.dart';
import 'text_field.dart';
import 'types.dart';

const _$TypeEnumMap = {
  FieldType.object: 'object',
  FieldType.array: 'array',
  FieldType.string: 'string',
  FieldType.number: 'number',
  FieldType.integer: 'integer',
  FieldType.boolean: 'boolean',
};

const _$WidgetEnumMap = {
  WidgetType.select: 'select',
  WidgetType.textarea: 'textarea',
  WidgetType.radio: 'radio',
};

class Section extends Field {
  final List<Field> fields;

  Section({
    String? id,
    String? title,
    String? description,
    FieldType? type,
    required this.fields,
  }) : super(
          id: id,
          title: title,
          description: description,
          fieldType: type,
        );

  factory Section.fromJson(Map<String, dynamic> json, Map<String, dynamic> ui) {
    return Section(
      title: json['title'],
      description: json['description'],
      type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
      fields: _stringToList(json['properties'], ui),
    );
  }

  static List<Field> _stringToList(Map<String, dynamic> json, Map<String, dynamic>? ui) {
    Map<String, dynamic> fieldMap = json;
    List<Field> fields = [];
    for (var field in fieldMap.entries) {
      Map<String, dynamic> lui = ui != null ? ui[field.key] ?? {} : {};
      fields.add(_mapToModel(field, lui));
    }
    return fields;
  }

  static Field _mapToModel(MapEntry<String, dynamic> fieldEntry, Map<String, dynamic> ui) {
    final id = fieldEntry.key;
    final field = fieldEntry.value;
    final type = field['type'];
    if (type == 'string') {
      return TextFieldModel(
        id: id,
        title: field['title'],
        description: field['description'],
        fieldType: $enumDecodeNullable(_$TypeEnumMap, type),
        widgetType: $enumDecodeNullable(_$WidgetEnumMap, ui['ui:widget']),
        enumOptions: field['enum'],
        enumNames: field['enumNames'],
      );
    } else {
      return Section(id: id, fields: _stringToList(field['properties'], ui[id]));
    }
  }
}
