import 'package:atna_json_schema_form/models/section.dart';
import 'package:atna_json_schema_form/widgets/section_widget.dart';
import 'package:flutter/cupertino.dart';

import 'models/array.dart';
import 'models/field.dart';
import 'models/text_field.dart';
import 'widgets/array_widget.dart';
import 'widgets/text_widget.dart';

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
