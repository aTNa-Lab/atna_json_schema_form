import 'package:atna_json_schema_form/helpers/helpers.dart';
import 'package:atna_json_schema_form/models/models.dart';

class Array extends Field {
  final bool isFixed;
  final List<Field>? items;
  final Field? itemType;

  Array({
    required String id,
    String? title,
    String? description,
    FieldType? fieldType,
    WidgetType? widgetType,
    required this.isFixed,
    this.items,
    this.itemType,
  }) : super(
          id: id,
          title: title,
          description: description,
          fieldType: fieldType,
          widgetType: widgetType,
        );
}
