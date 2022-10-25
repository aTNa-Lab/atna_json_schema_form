
import 'package:atna_json_schema_form/helpers/helpers.dart';
import 'package:atna_json_schema_form/models/models.dart';
import 'package:flutter/material.dart';

class ArrayWidget extends StatefulWidget {
  final Array model;

  const ArrayWidget({Key? key, required this.model}) : super(key: key);

  @override
  State<ArrayWidget> createState() => _ArrayWidgetState();
}

class _ArrayWidgetState extends State<ArrayWidget> {
  List<Field> fields = [];

  @override
  Widget build(BuildContext context) {
    if (widget.model.isFixed) {
      return FormBuilder(fields: widget.model.items!);
    } else {
      return Column(
        children: [
          FormBuilder(fields: fields),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  final field = widget.model.itemType!;
                  field.setId = fields.length.toString();
                  setState(() {
                    fields.add(field);
                  });
                },
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    fields.removeLast();
                  });
                },
                child: const Text('-'),
              ),
            ],
          )
        ],
      );
    }
  }
}
