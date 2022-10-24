import 'package:atna_json_schema_form/models/section.dart';
import 'package:atna_json_schema_form/widgets/section_widget.dart';
import 'package:flutter/cupertino.dart';

class FormBuilder extends StatefulWidget {
  final Section model;

  const FormBuilder({Key? key, required this.model}) : super(key: key);

  @override
  State<FormBuilder> createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {

  @override
  Widget build(BuildContext context) {
    return SectionWidget(model: widget.model);
  }
}
