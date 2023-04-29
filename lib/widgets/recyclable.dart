import 'package:flutter/material.dart';

class RecyclableForm extends StatefulWidget {
  const RecyclableForm({super.key});

  @override
  RecyclableFormState createState() {
    return RecyclableFormState();
  }
}

class RecyclableFormState extends State<RecyclableForm> {
  final formKey = GlobalKey<FormState>();
  String selectedValue = "paper";

  List<String> menuItems2 = ["paper", "glass", "plastic", "metal", "styrofoam"];

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "paper", child: Text("Paper")),
    const DropdownMenuItem(value: "glass", child: Text("Glass")),
    const DropdownMenuItem(value: "plastic", child: Text("Plastic")),
    const DropdownMenuItem(value: "metal", child: Text("Metal")),
    const DropdownMenuItem(value: "styrofoam", child: Text("Styrofoam"))
  ];

  Future<void> savingData() async {
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
            onChanged: (String? newValue) {
              setState(() {
                selectedValue = newValue!;
              });
            },
          ),
          ElevatedButton(
              onPressed: savingData,
              child: const Text("Is this recyclable?"))
        ],
      ),
    );
  }
}
