import 'package:firebase_connection/showData.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 53, 31, 255)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'FireBase Connection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getName = "";
  String getEmail = "";
  String getPassword = "";

  String dataName = "";
  String dataEmail = "";
  String dataPassword = "";

  void Save_Data() {
    setState(() {
      dataName = getName;
      dataEmail = getEmail;
      dataPassword = getPassword;

      try {
        FirebaseFirestore db = FirebaseFirestore.instance;
        db.collection('Users').add({
          'Name': dataName,
          'Email': dataEmail,
          'Password': dataPassword
        }).whenComplete(() {
          print("Data Save Successfully");
        });

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data Saved Successfully")));
      } catch (e) {
        print(e);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    "< SIGNUP FORM > ",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      backgroundColor: Color.fromARGB(255, 53, 31, 255),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: " Name",
                      labelText: " Enter Your Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    onChanged: (value) => getName = value,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: " Email",
                      labelText: " Enter Your Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    onChanged: (value) => getEmail = value,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: " Password",
                      labelText: " Enter Your Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.remove_red_eye),
                    ),
                    onChanged: (value) => getPassword = value,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 250,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: Save_Data,
                    child: Text("SUBMIT"),
                    style: ElevatedButton.styleFrom(
                      elevation: 15,
                      backgroundColor: Color.fromARGB(255, 53, 31, 255),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => show()));
              },
              child: Icon(Icons.show_chart_rounded),
            )
          ],
        ),
      ),
    );
  }
}
