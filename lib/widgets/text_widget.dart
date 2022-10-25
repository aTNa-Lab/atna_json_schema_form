import 'package:atna_json_schema_form/helpers/helpers.dart';
import 'package:atna_json_schema_form/models/models.dart';
import 'package:atna_json_schema_form/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatefulWidget {
  final TextFieldModel model;

  const TextWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  String selectedValue = "";

  final decoration = const InputDecoration(
    isDense: true,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 1.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    Widget field;
    if (widget.model.widgetType == WidgetType.select) {
      field = DropdownButtonFormField(
          decoration: decoration,
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue!;
            });
          },
          items: widget.model.dropdownItems);
    }
    field = TextFormField(
      decoration: decoration,
    );

    return FieldWrapper(
      title: widget.model.fieldTitle,
      description: widget.model.description,
      child: field,
    );
  }
}
