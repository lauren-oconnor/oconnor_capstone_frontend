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
  String shape = 'wide mouth bottle';
  final formKey = GlobalKey<FormState>();
  String selectedValue = "plastic";

  List<String> menuItems2 = ["paper", "glass", "plastic", "metal", "styrofoam"];

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "paper", child: Text("Paper")),
    const DropdownMenuItem(value: "glass", child: Text("Glass")),
    const DropdownMenuItem(value: "plastic", child: Text("Plastic")),
    const DropdownMenuItem(value: "metal", child: Text("Metal")),
    const DropdownMenuItem(value: "styrofoam", child: Text("Styrofoam"))
  ];

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
            value: selectedValue,
            items: menuItems,
            onChanged: (String? newValue) async {
              savingData(formKey);
              const url = 'http://127.0.0.1:5000/locationFeedback';
              final response = await http.post(
                Uri.parse(url),
                body: json.encode({'selectedMaterial': selectedValue, 'shape': shape, 'num': num, 'city': widget.city})
              );
              setState(() {
                selectedValue = newValue!;
                print(selectedValue);
              });
            },
          ),
          ElevatedButton(
              onPressed: () {
                print("is recyclable pressed");
                //getData from backend,
              },
              child: const Text("Is this recyclable?"))
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
