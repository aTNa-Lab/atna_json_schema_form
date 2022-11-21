import 'dart:convert';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_json_schema_form/flutter_json_schema_form.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      locale: const Locale('ru'),
      supportedLocales: const [
        Locale('ru'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
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
      "required": ["How old is your pet?", 'test'],
      "properties": {
        "firstName": {
          "type": "integer",
          "title": "First name",
          // "default": "Chuck",
        },
        "lastName": {
          "type": "number",
          // "default": 123,
          "title": "Last name",
        },
        "How old is your pet?": {
          "type": "integer",
          // "default": 1,
          "enum": [
            '1',
            '2',
            '3',
          ],
          "enumNames": ['One', 'Two', 'Three']
        },
        'test': {'type': 'boolean', 'title': 'Test'},
        "telephone": {
          "type": "array",
          "title": "Telephone",
          "items": {
            "title": "test",
            "type": "string",
            "default": "123",
          }
          // "items": [
          //   {"title": "test", "type": "string"},
          //   {"title": "test", "type": "string"},
          //   {"title": "test", "type": "string"},
          // ]
        },
        "person": {
          "title": "Person",
          "type": "object",
          "properties": {
            // "test": {
            //   "type": "object",
            //   "properties": {
            //     "test2": {
            //       "type": "object",
            //       "properties": {
            //         "multipleChoicesList": {
            //           "type": "array",
            //           "title": "A multiple choices list",
            //           "items": {
            //             "type": "string",
            //             "enum": [
            //               "foo",
            //               "bar",
            //               "fuzz",
            //               "qux"
            //             ]
            //           },
            //           "uniqueItems": true
            //         },
            //         "testFinal": {
            //           "title": "Final nested item"
            //         }
            //       }
            //     }
            //   }
            // },
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
    // schema = {
    //   "title": "Person",
    //   "type": "object",
    //   "properties": {
    //     "Do you have any pets?": {
    //       "type": "string",
    //       "enum": ["No", "Yes: One", "Yes: More than one"],
    //       "default": "No"
    //     }
    //   },
    //   "required": ["Do you have any pets?"],
    //   "dependencies": {
    //     "Do you have any pets?": {
    //       "oneOf": [
    //         {
    //           "properties": {
    //             "Do you have any pets?": {
    //               "enum": ["No"]
    //             }
    //           }
    //         },
    //         {
    //           "properties": {
    //             "Do you have any pets?": {
    //               "enum": ["Yes: One"]
    //             },
    //             "How old is your pet?": {"type": "integer"}
    //           },
    //           "required": ["How old is your pet?"]
    //         },
    //         {
    //           "properties": {
    //             "Do you have any pets?": {
    //               "enum": ["Yes: More than one"]
    //             },
    //             "Do you want to get rid of any?": {"type": "boolean"}
    //           },
    //           "required": ["Do you want to get rid of any?"]
    //         }
    //       ]
    //     }
    //   }
    // };
    // schema = {
    //   "title": "A registration form",
    //   "description": "A simple form example.",
    //   "type": "object",
    //   "required": ["firstName", "lastName"],
    //   "properties": {
    //     "person": {
    //       "title": "Person",
    //       "type": "object",
    //       "properties": {
    //         "test": {
    //           "type": "object",
    //           "properties": {
    //             "test2": {
    //               "type": "object",
    //               "properties": {
    //                 "multipleChoicesList": {
    //                   "type": "array",
    //                   "title": "A multiple choices list",
    //                   "items": {
    //                     "type": "string",
    //                     "enum": [
    //                       "foo",
    //                       "bar",
    //                       "fuzz",
    //                       "qux"
    //                     ]
    //                   },
    //                   "uniqueItems": true
    //                 },
    //                 "testFinal": {
    //                   "title": "Final nested item"
    //                 }
    //               }
    //             }
    //           }
    //         },
    //         // "test_string": {
    //         //   "type": "string",
    //         // },
    //         // "test": {"type": "boolean", "description": "This is sparta?"},
    //         "Do you have any pets?": {
    //           "type": "string",
    //           "enum": ["No", "Yes: One", "Yes: Two", "Yes: More than one"],
    //           "default": "No"
    //         }
    //       },
    //       "required": ["Do you have any pets?"],
    //       "dependencies": {
    //         "Do you have any pets?": {
    //           "oneOf": [
    //             {
    //               "properties": {
    //                 "Do you have any pets?": {
    //                   "enum": ["No"]
    //                 }
    //               }
    //             },
    //             {
    //               "properties": {
    //                 "Do you have any pets?": {
    //                   "enum": ["Yes: One", "Yes: Two"]
    //                 },
    //                 "How old is your pet?": {
    //                   "type": "integer",
    //                   "enum": [
    //                     '1',
    //                     '2',
    //                     '3',
    //                   ]
    //                 }
    //               },
    //               "required": ["How old is your pet?"]
    //             },
    //             {
    //               "properties": {
    //                 "Do you have any pets?": {
    //                   "enum": ["Yes: More than one"]
    //                 },
    //                 "Do you want to get rid of any?": {"type": "string"}
    //               },
    //               "required": ["Do you want to get rid of any?"]
    //             }
    //           ]
    //         }
    //       }
    //     }
    //   }
    // };

    ui = {
      // "telephone": {"ui:widget": "radio"},
      // "firstName": {
      //   "ui:widget": "file",
      // },
      "ui:order": [
        "telephone",
        "test",
        "*",
        "firstName",
      ],
      "person": {
        "test": {"ui:widget": "select"},
        // "How old is your pet?": {"ui:widget": "select"}
      },
      // "test": {"ui:widget": "radio"},
      // "How old is your pet?": {"ui:widget": "radio"},
      "Do you want to get rid of any?": {"ui:widget": "radio"},
    };
    // _formData = {'firstName2': 'test', 'firstName': 'atai', 'test-section': {'test1': 'section'}, 'fixedItemsList': [null, 'array']};
    _formData = {
      // "firstName": "Test",
      "telephone": ["a", "b", "c"]
      // "test": false,
      // "person": {"Do you have any pets?": "Yes: One"},
      // "Do you have any pets?": "Yes: More than one",
      // "Do you want to get rid of any?": true,
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

// TODO: Add more widgets. Use widgets from FlutterFormBuilder.
// TODO: Add ui:order, ui:options.
// TODO: Add WidgetModel and replace WidgetType wit WidgetModel.
// TODO: Refactor dispose method.
// TODO: Replace schema keys with constants.
// TODO: Add disabled.
