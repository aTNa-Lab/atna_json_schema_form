import 'dart:convert';

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
  late final Map<String, dynamic> schema;
  late final Map<String, dynamic> ui;

  @override
  void initState() {
    schema = {
      "title": "A registration form",
      "description": "A simple form example.",
      "type": "object",
      "required": ["firstName", "lastName"],
      "properties": {
        "person": {
          "title": "Person",
          "type": "object",
          "properties": {
            "test": {
              "type": "object",
              "properties": {
                "test2": {
                  "type": "object",
                  "properties": {
                    "multipleChoicesList": {
                      "type": "array",
                      "title": "A multiple choices list",
                      "items": {
                        "type": "string",
                        "enum": [
                          "foo",
                          "bar",
                          "fuzz",
                          "qux"
                        ]
                      },
                      "uniqueItems": true
                    },
                    "testFinal": {
                      "type": "string",
                      "title": "Final nested item"
                    }
                  }
                }
              }
            },
            // "test_string": {
            //   "type": "string",
            // },
            // "test": {"type": "boolean", "description": "This is sparta?"},
            "Do you have any pets?": {
              "type": "string",
              "enum": ["No", "Yes: One", "Yes: Two", "Yes: More than one"],
              "default": "No"
            }
          },
          "required": ["Do you have any pets?"],
          "dependencies": {
            "Do you have any pets?": {
              "oneOf": [
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["No"]
                    }
                  }
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: One", "Yes: Two"]
                    },
                    "How old is your pet?": {
                      "type": "integer",
                      "enum": [
                        '1',
                        '2',
                        '3',
                      ]
                    }
                  },
                  "required": ["How old is your pet?"]
                },
                {
                  "properties": {
                    "Do you have any pets?": {
                      "enum": ["Yes: More than one"]
                    },
                    "Do you want to get rid of any?": {"type": "string"}
                  },
                  "required": ["Do you want to get rid of any?"]
                }
              ]
            }
          }
        }
      }
    };

    ui = {
      "person": {
        "test": {"ui:widget": "select"},
        // "How old is your pet?": {"ui:widget": "select"}
      },
    };
    // _formData = {'firstName2': 'test', 'firstName': 'atai', 'test-section': {'test1': 'section'}, 'fixedItemsList': [null, 'array']};
    _formData = {
      "person": {"Do you have any pets?": "Yes: One"}
    };
    
    // final newData  = updateDeeply(['person', 'How old is your pet?'], _formData, (prevValue) => 1);
    // print('after ${newData.runtimeType}');
    // _formData = Map.from(newData);
    // _formData = {};
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
                schema: schema,
                uiSchema: ui,
                formData: _formData,
                onChange: (formData) {
                  print(json.encode(formData));
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
// TODO: Add required fields validation.
// TODO: Add more widgets.
// TODO: Add submit button.
// TODO: Add validations for widgets.
