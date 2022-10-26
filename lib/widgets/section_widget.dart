import 'package:atna_json_schema_form/helpers/helpers.dart';
import 'package:atna_json_schema_form/models/models.dart';
import 'package:atna_json_schema_form/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SectionWidget extends StatefulWidget {
  final Section model;

  const SectionWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  @override
  Widget build(BuildContext context) {
    return FieldWrapper.section(
      title: widget.model.fieldTitle,
      description: widget.model.description,
      child: FormBuilder(fields: widget.model.fields),
    );
  }
}
