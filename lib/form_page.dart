import 'package:flutter/material.dart';
import 'widgets/form.dart';
import 'utilities.dart';


/// Display recyclable form and retrieve user entries.
class FormPage extends StatelessWidget {
  FormPage({super.key, required this.city});

  String city;
  String message = '\n\n\tSorry, you\'re on your own. Recyclops doesn\'t yet'
                   ' have data on recycling\n capabilities for this city';

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () async {
        //print('doing stuff...');
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(city),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (city == 'denver' || city == 'anchorage')
                RecyclableForm(city: city)
              else
                Text(message, style: const TextStyle(fontSize: 24))
            ],
          ),
        ),
      ),
    );
  }
}

/*
class LocationFeedbackPage extends StatefulWidget{
  const LocationFeedbackPage({super.key});//, required this.city});
  //final String city;

  @override
  FormPageState createState() => FormPageState();
}

class FormPageState extends State<LocationFeedbackPage> {
  String city = "city goes here...";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Recyclable Finder')
      ),
      body: SizedBox(
        width: double.infinity,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RecyclableForm(city: city),
            Text(city, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
*/
