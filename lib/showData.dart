import 'package:firebase_connection/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const show());
}

class show extends StatelessWidget {
  const show({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  FirebaseFirestore db = FirebaseFirestore.instance;
  void delete_record(String i) {
    try {
      db.collection('Users').doc(i).delete();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data Has Been Removed")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  void update_data(
      BuildContext con, String userid, String username, String Email) {
    showDialog(
        context: con,
        builder: (Builder) => AlertDialog(
              title: Text("Update Record"),
              content: Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      constraints: BoxConstraints(maxWidth: 200),
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: username,
                          suffixIcon: Icon(Icons.person),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      constraints: BoxConstraints(maxWidth: 200),
                      child: TextField(
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: Email,
                          suffixIcon: Icon(Icons.email),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: db.collection("Users").snapshots(),
          builder: (Context, snapshot) {
            var get_data = snapshot.data!.docs;
            if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
              return Center(
                child: Text("No Data Found"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: get_data.length,
                itemBuilder: (context, index) {
                  String U_id = get_data[index].id;
                  var person_data =
                      get_data[index].data() as Map<String, dynamic>;
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      title: Text(person_data['Name'] ?? "Not Found"),
                      subtitle: Text(person_data['Email'] ?? "Not Found"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                update_data(context, U_id, person_data["Name"],
                                    person_data["Email"]);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 20,
                                color: Colors.green,
                              )),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (builder) => AlertDialog(
                                          content: Text(
                                              "Are You Sure! You want to delete this User ?"),
                                          title: Text("ConFirmation....??"),
                                          actions: [
                                            IconButton(
                                                onPressed: () {
                                                  delete_record(U_id);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                icon: Icon(Icons.check)),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                icon: Icon(Icons.cancel)),
                                          ],
                                        ));
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 20,
                                color: Colors.red,
                              )),
                        ],
                      ),
                    ),
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => MyApp()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// import 'package:firebase_connection/main.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'firebase_options.dart';

// void main() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const showData());
// }

// class showData extends StatelessWidget {
//   const showData({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   FirebaseFirestore db = FirebaseFirestore.instance;

//   void deleteRecord(String i) {
//     try {
//       db.collection("Users").doc(i).delete();
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text("Data has been Removed")));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
//     }
//   }

//   void update_data(
//       BuildContext con, String userid, String username, String Email) {
//     showDialog(
//         context: con,
//         builder: (Builder) => AlertDialog(
//               title: Text("Update Record"),
//               content: Container(
//                 child: Column(
//                   children: [
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       constraints: BoxConstraints(maxWidth: 200),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: UnderlineInputBorder(),
//                           labelText: username,
//                           suffixIcon: Icon(Icons.person),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.all(10),
//                       constraints: BoxConstraints(maxWidth: 200),
//                       child: TextField(
//                         decoration: InputDecoration(
//                           border: UnderlineInputBorder(),
//                           labelText: Email,
//                           suffixIcon: Icon(Icons.email),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: StreamBuilder(
//           stream: db.collection("Users").snapshots(),
//           builder: (Context, snapshot) {
//             var get_data = snapshot.data!.docs;
//             if (snapshot.data!.docs.isEmpty || !snapshot.hasData) {
//               return Center(
//                 child: Text("No Data Found"),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return ListView.builder(
//                 itemCount: get_data.length,
//                 itemBuilder: (context, index) {
//                   String u_id = get_data[index].id;
//                   var person_data =
//                       get_data[index].data() as Map<String, dynamic>;
//                   return Card(
//                     child: ListTile(
//                       leading: Icon(Icons.person),
//                       title: Text(person_data['Name'] ?? "Not Found"),
//                       subtitle: Text(person_data['Email'] ?? "Not Found"),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 update_data(context, u_id, person_data['Name'],
//                                     person_data['Email']);
//                               },
//                               icon: Icon(
//                                 Icons.edit,
//                                 size: 20,
//                                 color: Colors.green,
//                               )),
//                           IconButton(
//                               onPressed: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (builder) => AlertDialog(
//                                           content: Text(
//                                               "Are You Sure you want to delete this User"),
//                                           title: Text("ConFirmation....??"),
//                                           actions: [
//                                             IconButton(
//                                                 onPressed: () {
//                                                   deleteRecord(u_id);
//                                                   Navigator.of(context,
//                                                           rootNavigator: true)
//                                                       .pop();
//                                                 },
//                                                 icon: Icon(Icons.check)),
//                                             IconButton(
//                                                 onPressed: () {
//                                                   Navigator.of(context,
//                                                           rootNavigator: true)
//                                                       .pop();
//                                                 },
//                                                 icon: Icon(Icons.cancel)),
//                                           ],
//                                         ));
//                               },
//                               icon: Icon(
//                                 Icons.delete,
//                                 size: 20,
//                                 color: Colors.red,
//                               )),
//                         ],
//                       ),
//                     ),
//                   );
//                 });
//           }),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (builder) => MyApp()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
