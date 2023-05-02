import 'package:flutter/material.dart';


class ResultsPage extends StatelessWidget {
  ResultsPage({super.key, required this.city, required this.shape, required this.instructions, required this.material, required this.plasticNum});

  String instructions = '';
  String material = '';
  String plasticNum = '';
  String shape = '';
  String city = '';

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
            Text('\ninstructions recycling your \n$material '
                '#$plasticNum $shape in $city:',
                style: const TextStyle(fontSize: 24)
            ),
            Text('\n\n$instructions', style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
              ),
            )
          ],
        ),
      ),
    );
  }
}
