import 'package:atna_json_schema_form/form_builder.dart';
import 'package:flutter/material.dart';

import 'models/section.dart';

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
    };
    var test = Section.fromJson(json, ui);
    model = test;
    var f = test.fields.last as Section;
    print(f.fields);
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
        child: FormBuilder(
          model: model,
        ),
      ),
    );
  }
}
