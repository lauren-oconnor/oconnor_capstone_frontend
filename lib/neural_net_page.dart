import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class NeuralNetPage extends StatefulWidget{
  const NeuralNetPage({super.key});

  @override
  NeuralNetPageState createState() => NeuralNetPageState();
}


class NeuralNetPageState extends State<NeuralNetPage> {
  String message = '';
  String finalMessage = 'message...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Features of the Recyclops Neural Network')
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () async {
                  const url = 'http://127.0.0.1:5000/neuralNetwork';
                  final message = await http.get(Uri.parse(url));
                  final decoded = json.decode(message.body) as Map<String, dynamic>;
                  setState(() {
                    finalMessage = decoded['message'];
                    print(finalMessage);
                  });
                },
                child: const Text('get shape of input data')
            ),
            Text(finalMessage, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
