import 'package:flutter/material.dart';
import 'package:oconnor_capstone_frontend/location_page.dart';


/// Offer user the option to check the recyclability of an item.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}


class HomePageState extends State<HomePage> {
  String greetings = "";
  String city = "";
  String finalResponse = "";
  final formKey = GlobalKey<FormState>();

  get recyclableForm => null;

  Future<void> savingData() async {
    final validation = formKey.currentState?.validate();
    if (!validation!) {
      return;
    }
    formKey.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Recycling App Homepage')
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => const LocationPage())
                );
              },
              child: const Text('Go to Recyclables Page'),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}
