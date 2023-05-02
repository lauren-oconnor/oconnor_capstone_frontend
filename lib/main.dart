import 'package:flutter/material.dart';
import 'location_page.dart';
import 'home_page.dart';
import 'neural_net_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Recyclops Recycling App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/location",
      routes: {
        "/home": (context) => const HomePage(),
        "/location": (context) => const LocationPage(),
        "/neuralNetwork": (context) => const NeuralNetPage(),
      }
      //home: const HomePage(),
    );
  }
}


/*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(greetings, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Center(
            child: SizedBox(
              width: 150,
              height: 60,
              child: ElevatedButton(
                child: const Text('Press', style: TextStyle(fontSize: 24),),
                onPressed: () async {
                  print('button pressed');
                  Uri myUri = Uri.parse('http://127.0.0.1:5000/mary');
                  final response = await http.get(myUri);
                  final decoded = json.decode(response.body) as Map<String, dynamic>;
                  setState(() {
                    greetings = decoded['greetings'];
                  });
                }
              )
            )
          )
        ]
      )
    );
  }
}
*/

