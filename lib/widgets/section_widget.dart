import 'package:atna_json_schema_form/field_wrapper.dart';
import 'package:atna_json_schema_form/form_builder.dart';
import 'package:atna_json_schema_form/models/section.dart';
import 'package:flutter/cupertino.dart';

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
        child: FormBuilder(fields: widget.model.fields));
  }
}
