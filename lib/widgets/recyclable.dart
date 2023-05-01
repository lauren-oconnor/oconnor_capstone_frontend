import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utilities.dart';


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
  String instructions = '';
  String finalResponse = '';
  String material = "glass";

  final formKey = GlobalKey<FormState>();

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

              const url = 'http://127.0.0.1:5000/location';
              final response = await http.get(Uri.parse(url));
              print(response);
              //final decoded = json.decode(response.body) as Map<String, dynamic>;
              setState(() {
                //instructions = decoded['instructions'];
                material = newValue!;
                print(material);
              });
            },
          ),
          ElevatedButton(
              onPressed: () async {
                savingData(formKey);
                print('material: $material');     //interpolation instead of concatenation
                print('shape: $shape');
                /*if (formKey.currentState!.validate()) {
                  formKey.currentState?.save();
                }*/
                const url = 'http://127.0.0.1:5000/locationFeedback';
                final response = await http.post(
                    Uri.parse(url),
                    body: json.encode({'selectedMaterial': material, 'shape': shape, 'num': num, 'city': widget.city})
                );
                //getData from backend,
              },
              child: const Text("Is this recyclable?")
          ),
          ElevatedButton(
            onPressed: () async {
              const url = 'http://127.0.0.1:5000/locationFeedback';
              final response = await http.get(Uri.parse(url));
              final decoded =json.decode(response.body) as Map<String, dynamic>;
              setState(() {
                finalResponse = decoded['instructions'];
                print(finalResponse);
              });
            },
            child: const Text("Get instructions"),
          ),
          Text(finalResponse, style: const TextStyle(fontSize: 24))
        ],
      ),
    );
  }
}
