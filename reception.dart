import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class Patient {
  final String name;
  final String description;

  Patient(this.name, this.description);

  static List<Patient> getPatients() {
    List<Patient> items = <Patient>[];
    items.add(
        Patient(
            "Patient 1",
            "Cough, Fever",
        )
    );
    items.add(
        Patient(
            "Patient 2",
            "Fever, body aches",
        )
    );
    return items;
  }
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reception',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Reception demo home page'),
    );
  }
}
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  final items = Patient.getPatients();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Reception")),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: PatientBox(item: items[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientPage(item: items[index]),
                  ),
                );
              },
            );
          },
        )
    );
  }
}
class PatientPage extends StatelessWidget {
  PatientPage({Key key, this.item}) : super(key: key);
  final Patient item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.name),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                          ],
                        )
                    )
                )
              ]
          ),
        ),
      ),
    );
  }
}

class PatientBox extends StatelessWidget {
  PatientBox({Key key, this.item}) : super(key: key);
  final Patient item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)), Text(this.item.description),
                          ],
                        )
                    )
                )
              ]
          ),
        )
    );
  }
}
