import 'package:atna_json_schema_form/helpers/helpers.dart';
import 'package:atna_json_schema_form/models/models.dart';
import 'package:flutter/material.dart';


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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final Section model;

  @override
  void initState() {
    var json = {
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
          "items": {
            "type": "string",
            "default": "bazinga"
          }
        },
        "fixedItemsList": {
          "type": "array",
          "title": "A list of fixed items",
          "items": [
            {
              "title": "A string value",
              "type": "string",
              "default": "lorem ipsum"
            },
            {
              "title": "a boolean value",
              "type": "string"
            }
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
          "properties": {
            "test1": {
              "type": "string"
            }
          }
        }
      }
    };

    var ui = {
      "firstName": {"ui:widget": "select"},
      "lastName": {"ui:widget": "textarea"},
      "fixedItemsList": {
        "items": [
          {
            "ui:widget": "textarea"
          },
          {
            "ui:widget": "select"
          }
        ],
      },
    };
    model = Section.fromJson(json, ui);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: FormBuilder(
            fields: model.fields,
          ),
        ),
      ),
    );
  }
}
