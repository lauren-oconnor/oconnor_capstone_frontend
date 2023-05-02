// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utilities.dart';
import 'package:oconnor_capstone_frontend/search_results_page.dart';


/// Conditionally display form fields to user and obtain their responses.
/// Navigate to Search Results Page when the user submits the form.
/// Send/get data from the backend endpoint to query the database.
class RecyclableForm extends StatefulWidget {
  const RecyclableForm({super.key, required this.city});
  final String city;

  @override
  RecyclableFormState createState() {
    return RecyclableFormState();
  }
}

class RecyclableFormState extends State<RecyclableForm> {
  String plasticNum = "";
  String shape = '';
  String finalResponse = '';
  String material = "";
  String instrxns = '';
  bool showPlasticShapes = false;

  final formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "paper", child: Text("Paper")),
    const DropdownMenuItem(value: "glass", child: Text("Glass")),
    const DropdownMenuItem(value: "plastic", child: Text("Plastic")),
    const DropdownMenuItem(value: "metal", child: Text("Metal")),
    const DropdownMenuItem(value: "styrofoam", child: Text("Styrofoam")),
    const DropdownMenuItem(value: "", child: Text(" "))
  ];

  List<DropdownMenuItem<String>> nums = [
    const DropdownMenuItem(value: "1", child: Text("#1: PET")),
    const DropdownMenuItem(value: "2", child: Text("#2: HDPE")),
    const DropdownMenuItem(value: "3", child: Text("#3: PVC")),
    const DropdownMenuItem(value: "4", child: Text("#4: LDPE")),
    const DropdownMenuItem(value: "5", child: Text("#5: PP")),
    const DropdownMenuItem(value: "6", child: Text("#6: PS")),
    const DropdownMenuItem(value: "7", child: Text("#7: BPA/PC/LEXAN")),
    const DropdownMenuItem(value: "", child: Text(" ")),

  ];

  List<DropdownMenuItem<String>> plasticShapes = [
    const DropdownMenuItem(value: "wide mouth bottle", child: Text("Wide-Mouth Bottle")),
    const DropdownMenuItem(value: "narrow mouth bottle", child: Text("Narrow-Mouth Bottle")),
    const DropdownMenuItem(value: "bag", child: Text("Bag")),
    const DropdownMenuItem(value: "clamshell", child: Text("Clam Shell")),
    const DropdownMenuItem(value: "", child: Text(" "))
  ];

  List<DropdownMenuItem<String>> metalShapes = [
    const DropdownMenuItem(value: "foil", child: Text("Foil")),
    const DropdownMenuItem(value: "scrap metal", child: Text("Scrap Metal")),
    const DropdownMenuItem(value: "soda can", child: Text("Bag")),
    const DropdownMenuItem(value: "soup can", child: Text("Clam Shell")),
    const DropdownMenuItem(value: "", child: Text(" "))
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget> [
          const SizedBox(height: 50),
          const Text('Select your item\'s material:'),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: inputFormDeco(),
              focusedBorder: inputFormDeco(),
              filled: true,
              fillColor: Colors.white38,
            ),
            hint: const Text('Select your item\'s material'),
            value: material,
            items: menuItems,
            onChanged: (String? newValue) async {
              savingData(formKey);
              const url = 'http://127.0.0.1:5000/location';
              final response = await http.get(Uri.parse(url));
              print(response);
              setState(() {
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
                  setState(() {
                    plasticNum = newValue!;
                    showPlasticShapes = true;
                    print(material);
                  }
                );
              },
            ),
          const SizedBox(height: 20),
          if (showPlasticShapes)
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                enabledBorder: inputFormDeco(),
                focusedBorder: inputFormDeco(),
              ),
              items: plasticShapes,
              elevation: 16,
              hint: const Text('select your plastic shape'),
              onChanged: (String? newValue) async {
                savingData(formKey);
                setState(() {
                  shape = newValue!;
                  print(shape);
                }
                );
              },
            ),
          const SizedBox(height: 20),
          if (material == 'metal')
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              enabledBorder: inputFormDeco(),
              focusedBorder: inputFormDeco(),
            ),
            items: metalShapes,
            elevation: 16,
            hint: const Text('select your metal shape'),
            onChanged: (String? newValue) async {
              savingData(formKey);
              setState(() {
              shape = newValue!;
              print(shape);
              });
            },
          ),
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
                instrxns = instructions.toString();
                print('from is this recyclable: ' + instructions.toString());
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ResultsPage(city: widget.city, shape: shape, instructions: instrxns, material: material, plasticNum: plasticNum))
                );
              },
              child: const Text("Is this recyclable?")
          ),

          Text(finalResponse, style: const TextStyle(fontSize: 24))
        ],
      ),
    );
  }
}
