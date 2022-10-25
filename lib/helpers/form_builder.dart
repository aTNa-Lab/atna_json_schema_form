import 'package:atna_json_schema_form/models/models.dart';
import 'package:atna_json_schema_form/widgets/widgets.dart';
import 'package:flutter/material.dart';

class FormBuilder extends StatelessWidget {
  final List<Field> fields;

  const FormBuilder({Key? key, required this.fields}) : super(key: key);

  Widget _mapModelToWidget(Field model) {
    if (model is TextFieldModel) {
      return TextWidget(model: model);
    } else if (model is Section) {
      return SectionWidget(model: model);
    } else if (model is Array) {
      return ArrayWidget(model: model);
    }
    return const Text('Error: widget not found');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fields.length,
      itemBuilder: (context, index) {
        final model = fields[index];
        print(model.id);
        return _mapModelToWidget(model);
      },
    );
  }
}
