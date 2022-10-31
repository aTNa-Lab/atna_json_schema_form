import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic> _formData;
  late final Map<String, dynamic> json;
  late final Map<String, dynamic> ui;

  @override
  void initState() {
    json = {
      "title": "A registration form",
      "description": "A simple form examplae.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "firstName": {
          "type": "string",
          "title": "First name",
          "description": "Test Description",
          "enum": ["atai", "btai", "ctai"],
          "enumNames": ['1', '2']
        },
        "listOfStrings": {
          "type": "array",
          "title": "A list of strings",
          "items": {"type": "string", "title": "test item"}
        },
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": [
            {"title": "A string value", "type": "string", "default": "lorem ipsum"},
            {"title": "a boolean value", "type": "string"},
            {"title": "third item", "type": "string"}
          ],
        },
        "firstName2": {
          "type": "string",
          "title": "First name 2",
          "description": "Test Description",
          "enum": ["atai", "btai", "ctai"],
          "enumNames": ['1', '2']
        },
        "firstName3": {
          "type": "string",
          "title": "First name",
          "description": "Test Description",
          "enum": ["atai", "btai", "ctai"],
          "enumNames": ['1', '2']
        },
        "lastName": {"type": "string", "description": "Test Description", "title": "Last name"},
        "telephone": {"type": "string", "title": "Telephone", "minLength": 10},
        "test-section": {
          "title": "123",
          "type": "object",
          "properties": {
            "test1": {"type": "string"}
          }
        }
      }
    };

    ui = {
      "firstName": {"ui:widget": "select"},
      "lastName": {"ui:widget": "textarea"},
      "fixedItemsList": {
        "items": [
          {"ui:widget": "textarea"},
        ],
      },
    };
    _formData = {'firstName2': 'test', 'firstName': 'atai', 'test-section': {'test1': 'section'}, 'fixedItemsList': [null, 'array']};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FlutterJsonSchemaForm(
                schema: json,
                uiSchema: ui,
                formData: _formData,
                onChange: (formData) {
                  setState(() {
                    _formData = formData;
                  });
                },
              ),
            ),
            Text(_formData.toString()),
          ],
        ),
      ),
    );
  }
}


// TODO: Add default value calculation.
// TODO: Add dependency support.
// TODO: Add required fields validation.
// TODO: Add more widgets.
// TODO: Add submit button.
// TODO: Add validations for widgets.