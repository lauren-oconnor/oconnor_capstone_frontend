import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'utilities.dart';
import 'form_page.dart';


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
                    //savingData(formKey);
                  }
                  /*
                  onFieldSubmitted: (value){
                    city = value;
                    city = city.toLowerCase();
                    savingData(formKey);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => FormPage(city: city))
                    );
                  },*/
                ),
              ),
            ),
            const Text('hint: choose Anchorage, Denver, or Paris'),
            ElevatedButton(
                onPressed: () async {
                  savingData(formKey);
                  const url = 'http//127.0.0.1:/locationFeedback';
                  final response = await http.post(
                      Uri.parse(url), body: json.encode({'city': city})
                  );
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
