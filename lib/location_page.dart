// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'utilities.dart';
import 'form_page.dart';


///Obtain the user's municipality and select the corresponding database.
///Redirect to the form page when the user submits their response.
class LocationPage extends StatefulWidget{
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}

class LocationPageState extends State<LocationPage> {
  final formKey = GlobalKey<FormState>();
  String city = "";
  //bool _cityFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Location Selection')
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            SizedBox(width: 350,
              child: Form(
                key: formKey,
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Enter your city\'s name: ',
                    enabledBorder: inputFormDeco(),
                    focusedBorder: inputFormDeco(),
                  ),
                  onSaved:  (value) {
                    city = value!;
                    city = city.toLowerCase();
                  }
                ),
              ),
            ),
            const Text('hint: choose Anchorage, Denver, or Paris'),
            ElevatedButton(
                onPressed: () async {
                  savingData(formKey);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => FormPage(city: city))
                  );
                },
                child: const Text('Submit')
            ),
          ],
        ),
      ),
    );
  }
}
