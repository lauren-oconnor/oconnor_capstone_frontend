import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utilities.dart';



class ResultsPage extends StatelessWidget {
  ResultsPage({super.key, required this.instructions, required this.material, required this.plasticNum});
  String instructions = '';
  String material = '';
  String plasticNum = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Recycling Instructions')
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            /*
            ElevatedButton(
                onPressed: () async {
                  const url = 'http://127.0.0.1:5000/search_results';
                  final message = await http.get(Uri.parse(url));
                  final decoded = json.decode(message.body) as Map<String, dynamic>;

                    instructions = decoded['instructions'];
                    print(instructions);
                  },

                child: const Text('get instructions')
            ),*/
            Text('from parameters to results page:' + instructions + " " + material)
          ],
        ),
      ),
    );
  }
}
// '/search_results'