import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class RecyclableForm extends StatefulWidget {
  const RecyclableForm({super.key, required this.city});
  final String city;

  @override
  RecyclableFormState createState() {
    return RecyclableFormState();
  }
}

class RecyclableFormState extends State<RecyclableForm> {
  int num = 2;
  String shape = 'narrow mouth bottle';
  final formKey = GlobalKey<FormState>();
  //final formKey2 = GlobalKey<FormState>();

  String material = "glass";

  List<String> menuItems2 = ["paper", "glass", "plastic", "metal", "styrofoam"];

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "paper", child: Text("Paper")),
    const DropdownMenuItem(value: "glass", child: Text("Glass")),
    const DropdownMenuItem(value: "plastic", child: Text("Plastic")),
    const DropdownMenuItem(value: "metal", child: Text("Metal")),
    const DropdownMenuItem(value: "styrofoam", child: Text("Styrofoam"))
  ];

  List<DropdownMenuItem<String>> plasticShapes = [
    const DropdownMenuItem(value: "wide mouth bottle", child: Text("Wide-Mouth Bottle")),
    const DropdownMenuItem(value: "narrow mouth bottle", child: Text("Narrow-Mouth Bottle")),
    const DropdownMenuItem(value: "bag", child: Text("Bag")),
    const DropdownMenuItem(value: "clamshell", child: Text("Clam Shell"))
  ];

  /*
  List<DropdownMenuItem<String>> metalShapes = [
    const DropdownMenuItem(value: "soda can", child: Text("Soda Can")),
    const DropdownMenuItem(value: "scrap", child: Text("Scrap Metal")),
    const DropdownMenuItem(value: "tin can", child: Text("Tin Can")),
    const DropdownMenuItem(value: "foil", child: Text("Foil")),
  ];


  List<DropdownMenuItem<String>> shapeDropdown(String material) {
    List<DropdownMenuItem<String>> menuItems = [];

    switch(material) {
      case 'plastic':
        menuItems = [
          const DropdownMenuItem(value: "wide mouth bottle", child: Text("Wide-Mouth Bottle")),
          const DropdownMenuItem(value: "narrow mouth bottle", child: Text("Narrow-Mouth Bottle")),
          const DropdownMenuItem(value: "bag", child: Text("Bag")),
          const DropdownMenuItem(value: "clamshell", child: Text("Clam Shell")),
        ];
        break;
      case 'metal':
        menuItems = [
          const DropdownMenuItem(value: "soda can", child: Text("Soda Can")),
          const DropdownMenuItem(value: "scrap", child: Text("Scrap Metal")),
          const DropdownMenuItem(value: "tin can", child: Text("Tin Can")),
          const DropdownMenuItem(value: "foil", child: Text("Foil")),
        ];
        break;
      default:
        menuItems = [];

    }
    return menuItems;
  }
*/
  Future<void> savingData(formKey) async {
    final validation = formKey.currentState?.validate();
    if (!validation!) {
      return;
    }
    formKey.currentState!.save();
  }

  OutlineInputBorder inputFormDeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
      const BorderSide(
          width: 1.0,
          color: Colors.lightGreen,
          style: BorderStyle.solid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget> [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: inputFormDeco(),
              focusedBorder: inputFormDeco(),
            ),
            value: material,
            items: menuItems,
            onChanged: (String? newValue) async {
              savingData(formKey);

              /*
              const url = 'http://127.0.0.1:5000/locationFeedback';
              final response = await http.post(
                Uri.parse(url),
                body: json.encode({'selectedMaterial': selectedValue, 'shape': shape, 'num': num, 'city': widget.city})
              );*/
              setState(() {
                material = newValue!;
                print(material);
              });

            },
          ),

          /*if (material == 'plastic')
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: inputFormDeco(),
                focusedBorder: inputFormDeco(),
              ),
              value: shape,
              items: menuItems,
              onChanged: (String? newValue2) async {
                savingData(formKey);
                /*
                        const url = 'http://127.0.0.1:5000/locationFeedback';
                        final response = await http.post(
                          Uri.parse(url),
                          body: json.encode({'selectedMaterial': selectedValue, 'shape': shape, 'num': num, 'city': widget.city})
                        );*/
                print(shape);
                setState(() {
                  shape = newValue2!;
                  print(shape);
                });
              },
            ),*/

          ElevatedButton(
              onPressed: () async {
                const url = 'http://127.0.0.1:5000/locationFeedback';
                final response = await http.post(
                    Uri.parse(url),
                    body: json.encode({'selectedMaterial': material, 'shape': shape, 'num': num, 'city': widget.city})
                );
                //getData from backend,
              },
              child: const Text("Is this recyclable?")
          ),
        ],
      ),
    );
  }
}

Future<void> savingData(formKey) async {
  final validation = formKey.currentState?.validate();
  if (!validation!) {
    return;
  }
  formKey.currentState!.save();
}


