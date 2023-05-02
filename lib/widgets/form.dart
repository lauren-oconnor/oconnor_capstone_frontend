import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utilities.dart';
import 'package:oconnor_capstone_frontend/search_results_page.dart';


class RecyclableForm extends StatefulWidget {
  const RecyclableForm({super.key, required this.city});
  final String city;

  @override
  RecyclableFormState createState() {
    return RecyclableFormState();
  }
}

class RecyclableFormState extends State<RecyclableForm> {
  String plasticNum = "1";
  String shape = 'dummy shape';
  String instructions = 'dummy instructions';
  String finalResponse = '';
  int current = 1;
  String material = "paper";
  String instrxn3 = '';

  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "paper", child: Text("Paper")),
    const DropdownMenuItem(value: "glass", child: Text("Glass")),
    const DropdownMenuItem(value: "plastic", child: Text("Plastic")),
    const DropdownMenuItem(value: "metal", child: Text("Metal")),
    const DropdownMenuItem(value: "styrofoam", child: Text("Styrofoam"))
  ];

  List<DropdownMenuItem<String>> nums = [
    const DropdownMenuItem(value: "1", child: Text("#1: PET")),
    const DropdownMenuItem(value: "2", child: Text("#2: HDPE")),
    const DropdownMenuItem(value: "3", child: Text("#3: PVC")),
    const DropdownMenuItem(value: "4", child: Text("#4: LDPE")),
    const DropdownMenuItem(value: "5", child: Text("#5: PP")),
    const DropdownMenuItem(value: "6", child: Text("#6: PS")),
    const DropdownMenuItem(value: "7", child: Text("#7: BPA/PC/LEXAN")),
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
          const SizedBox(height: 50),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: inputFormDeco(),
              focusedBorder: inputFormDeco(),
            ),
            value: material,
            items: menuItems,
            hint: const Text('Select your item\'s material'),
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
          const SizedBox(height: 20),
          if (material == 'plastic')
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: inputFormDeco(),
                focusedBorder: inputFormDeco(),
              ),
              items: nums,
              elevation: 16,
              hint: const Text('select your plastic number'),
              onChanged: (String? newValue) async {
                  savingData(formKey);
                  const url = 'http://127.0.0.1:5000/location';
                  final response = await http.get(Uri.parse(url));
                  //final decoded = json.decode(response.body) as Map<String, dynamic>;
                  setState(() {
                    plasticNum = newValue!;
                    print(material);
                  }
                );
              },
            )
            else if (material == 'glass')
              const Text('')
            else if (material == 'paper')
              const Text('')
            else if (material == 'metal')
              const Text('item is metal')
            else if (material == 'styrofoam')
              const Text('item is styrofoam'),
          ElevatedButton(
              onPressed: () async {
                savingData(formKey);
                print('material: $material');     //interpolation instead of concatenation
                print('shape: $shape');
                print('plasticNum: $plasticNum');
                //instructions = 'blah blah blah';
                const url = 'http://127.0.0.1:5000/locationFeedback';
                final response = await http.post(
                    Uri.parse(url),
                    body: json.encode({'selectedMaterial': material, 'shape': shape, 'plasticNum': plasticNum, 'city': widget.city})
                );
                final instructions = json.decode(response.body) as Map<String, dynamic>;//response.toString();
                instrxn3 = instructions.toString();
                print('from isthisrecyclable: ' + instructions.toString());
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ResultsPage(instructions: instrxn3, material: material, plasticNum: plasticNum))
                );/*
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ResultsPage(instructions: 'bananas!'))
                );*/
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
