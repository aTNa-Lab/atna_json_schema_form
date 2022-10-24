import 'package:atna_json_schema_form/field_wrapper.dart';
import 'package:atna_json_schema_form/form_builder.dart';
import 'package:atna_json_schema_form/models/field.dart';
import 'package:atna_json_schema_form/models/section.dart';
import 'package:atna_json_schema_form/models/text_field.dart';
import 'package:atna_json_schema_form/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';

class SectionWidget extends StatefulWidget {
  final Section model;

  const SectionWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<SectionWidget> createState() => _SectionWidgetState();
}

class _SectionWidgetState extends State<SectionWidget> {
  Widget _mapModelToWidget(Field model) {
    if (model is TextFieldModel) {
      return TextWidget(model: model);
    } else if (model is Section) {
      return FormBuilder(model: model);
    }
    return const Text('Error: widget not found');
  }

  @override
  Widget build(BuildContext context) {
    return FieldWrapper.section(
      title: widget.model.fieldTitle,
      description: widget.model.description,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.model.fields.length,
        itemBuilder: (context, index) {
          final model = widget.model.fields[index];
          return _mapModelToWidget(model);
        },
      ),
    );
  }
}
