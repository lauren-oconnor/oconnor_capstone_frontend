import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/recyclable.dart';
import 'utilities.dart';


void main() {
  runApp(const MyApp());
}
/*
OutlineInputBorder inputFormDeco() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide:
    const BorderSide(
        width: 1.0,
        color: Colors.lightGreen,
        style: BorderStyle.solid),
  );
}


Future<void> savingData(formKey) async {
  final validation = formKey.currentState?.validate();
  if (!validation!) {
    return;
  }
  formKey.currentState!.save();
}
*/

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


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}


class LocationPage extends StatefulWidget{
  const LocationPage({super.key});

  @override
  LocationPageState createState() => LocationPageState();
}


class NeuralNetPage extends StatefulWidget{
  const NeuralNetPage({super.key});

  @override
  NeuralNetPageState createState() => NeuralNetPageState();
}


class LocationFeedbackPage extends StatefulWidget{
  const LocationFeedbackPage({super.key});//, required this.city});
  //final String city;

  @override
  LocationFeedbackPageState createState() => LocationFeedbackPageState();
}

///Adds state initiation capabilities to Stateless widgets.
///
/// see:
///citation: https://medium.com/filledstacks/how-to-call-a-function-on-start-in-flutter-stateless-widgets-28d90ab3bf49

class StatefulWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;
  const StatefulWrapper({super.key, required this.onInit, required this.child});

  @override
  StatefulWrapperState createState() => StatefulWrapperState();
}


class LocationFeedbackScreen extends StatelessWidget {
  const LocationFeedbackScreen({super.key, required this.city});

  final String city;
  final String message = '\n\n\tSorry, you\'re on your own. Recyclops doesn\'t yet have data on recycling\n capabilities for this city';

  @override
  Widget build(BuildContext context) {
    return StatefulWrapper(
      onInit: () {
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


class StatefulWrapperState extends State<StatefulWrapper> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
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
/*
  OutlineInputBorder inputFormDeco() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide:
      const BorderSide(
          width: 1.0,
          color: Colors.lightGreen,
          style: BorderStyle.solid
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Recyclops Recycling App')
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
                  onSaved: (value) {
                    city = value!;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                savingData();
                const url = 'http://127.0.0.1:5000/city';
                final response = await http.post(
                    Uri.parse(url),
                    body: json.encode({'city': city})
                );
              },
              child: const Text('SEND'),
            ),
            ElevatedButton(
              onPressed: () async {
                const url = 'http://127.0.0.1:5000/city';
                final response = await http.get(Uri.parse(url));
                final decoded = json.decode(response.body) as Map<String, dynamic>;
                setState(() {
                  finalResponse = decoded['city'];
                });
              },
              child: const Text('GET'),
            ),
            Text(finalResponse, style: const TextStyle(fontSize: 24)),
            RecyclableForm(city: city),
          ],
        ),
      ),
    );
  }
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
                  onFieldSubmitted: (value){
                    city = value!;
                    city = city.toLowerCase();
                    savingData(formKey);
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => LocationFeedbackScreen(city: city))
                    );
                  },
                ),
              ),
            ),
            /* ElevatedButton(
                      onPressed: () async {
                        savingData(formKey);
                        const url = 'http://127.0.0.1:5000/city';
                        final response = await http.post(
                            Uri.parse(url),
                            body: json.encode({'city': city})
                        );
                      },
                      child: const Text('submit'),

                    ),*/
            ElevatedButton(
                onPressed: () async {
                  savingData(formKey);
                  const url = 'http//127.0.0.1:/city';
                  final response = await http.post(
                      Uri.parse(url), body: json.encode({'city': city})
                  );
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => LocationFeedbackScreen(city: city))
                  );
                },
                child: const Text('multi button')
            ),
            /*ElevatedButton(
                      onPressed: () async {
                        const url = 'http://127.0.0.1:5000/city';
                        final response = await http.get(Uri.parse(url));
                        final decoded = json.decode(response.body) as Map<String, dynamic>;
                        setState(() {
                          finalResponse = decoded['city'];
                          print(finalResponse);
                        });
                        if (finalResponse[0] == 'L') {
                          _cityFound = true;
                        }
                      },
                      child: const Text('GET'),
                    ),*/
            //Text(finalResponse, style: const TextStyle(fontSize: 24)),
            /*ElevatedButton(
                        onPressed: _cityFound
                            ? () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LocationFeedbackScreen(city: city)));
                            }
                            : null,
                        child: const Text('onward -->'),
                    )*/
          ],
        ),
      ),
    );
  }
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


class LocationFeedbackPageState extends State<LocationFeedbackPage> {
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

/*
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  String url = "";
  String data = "";
  String queryText = 'Query';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: const Text("Quote scraper"),
      ),
      body: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();

}

class MainScreenState extends State<MainScreen> {
  int _itemCount = 0;
  var jsonResponse;
  String query = "";

  Future<void> getQuotes(query) async {
    String url = "http://10.0.2.2:500/?query=$query";   //localhost for android todo switch to localhost?
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      setState(() {
        jsonResponse = convert.jsonDecode(response.body);
        _itemCount = jsonResponse.length;
      });
      //jsonResponse[0]["author"];
      //jsonResponse[0]["quote"];
      print("num quotes found: $_itemCount.");
    }
    else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center (
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: _itemCount== 0 ? 50 : 350,
              child: _itemCount == 0
                ? const Text("Loading...")
                  : ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          jsonResponse[index]["quote"],
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          jsonResponse[index]["author"],
                          style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: _itemCount,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "search quotes here",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder
                        (borderSide: BorderSide(color: Colors.white)),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
                    onChanged: (value){
                      query = value;
                      print(value);
                    },
                    onSubmitted: (value) {
                      print(value);
                    },
                  ),
                  ButtonTheme(
                    minWidth: 100,
                      child: ElevatedButton(
                        child: const Text(
                          "get quotes",
                          style: TextStyle(color: Colors.white)
                        ),
                        //color: Colors.black87,
                        onPressed: () {
                          getQuotes(query);
                          setState(() {
                            _itemCount = 0;
                          });
                        }
                      ),
                  )
                ]
              )
            )
          ],
        )
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PYTHON AND FLUTTER'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: (value) {
                  // String interpolation (below) concatenates strings in dart
                  url = 'http://10.0.2.2:5000/api?Query=$value';
                },
                decoration: InputDecoration(
                    hintText: 'Search Anything Here',
                    suffixIcon: GestureDetector(
                      // asynchronous methods like onTap, below, cause the
                      // program to expect their result while proceeding to
                      // other tasks https://dart.dev/codelabs/async-await
                        onTap: () async {
                          data = await getData(url);
                          var decodedData = jsonDecode(data);
                          setState(() {
                            queryText = decodedData['Query'];
                          });
                        },
                        child: const Icon(Icons.search))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                queryText,
                style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

*/
