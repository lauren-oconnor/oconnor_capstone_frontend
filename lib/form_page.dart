import 'package:flutter/material.dart';
import 'widgets/form.dart';
import 'utilities.dart';

class FormPageState extends State<LocationFeedbackPage> {
  String city = "city goes here...";
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Material Selection')
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


class FormPage extends StatelessWidget {
  FormPage({super.key, required this.city});

  final String city;
  final String message = '\n\n\tSorry, you\'re on your own. Recyclops doesn\'t yet have data on recycling\n capabilities for this city';
  bool cityFound = true;

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
        //todo, search db?
        cityFound = false;
        print('doing stuff...');
        const Text('doing stuff');
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
              //Text(city),

              if (cityFound) //city == 'denver' || city == 'anchorage')
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


class LocationFeedbackPage extends StatefulWidget{
  const LocationFeedbackPage({super.key});//, required this.city});
  //final String city;

  @override
  FormPageState createState() => FormPageState();
}
