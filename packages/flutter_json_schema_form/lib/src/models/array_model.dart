import '../helpers/helpers.dart';
import 'models.dart';

class Array extends FieldModel {
  final bool isFixed;
  final List<FieldModel>? items;
  final FieldModel? itemType;

  Array.dynamic({
    required String id,
    String? title,
    String? description,
    FieldType? fieldType,
    WidgetType? widgetType,
    this.itemType,
    required PathModel path,
  })  : isFixed = false,
        items = null,
        super.init(
          id: id,
          title: title,
          description: description,
          fieldType: fieldType,
          widgetType: widgetType,
          path: path,
        );

  Array.fixed({
    required String id,
    String? title,
    String? description,
    FieldType? fieldType,
    WidgetType? widgetType,
    required this.items,
    required PathModel path,
  })  : itemType = null,
        isFixed = true,
        super.init(
          id: id,
          title: title,
          description: description,
          fieldType: fieldType,
          widgetType: widgetType,
          path: path,
        );
}