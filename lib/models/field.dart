import 'package:atna_json_schema_form/models/types.dart';

abstract class Field {
  String? id;
  String? title;
  String? description;
  FieldType? fieldType;
  WidgetType? widgetType;

  Field({
    this.id,
    this.title,
    this.description,
    this.fieldType,
    this.widgetType,
  });

  String? get fieldTitle => title ?? id;
}