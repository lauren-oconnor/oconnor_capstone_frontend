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
      initialRoute: "/home",
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
