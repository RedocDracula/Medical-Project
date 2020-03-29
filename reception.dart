import 'package:flutter/material.dart';
void main() => runApp(MyApp());

class Doctor {
  final String name;

  Doctor(this.name);

  static List<Doctor> getDoctors() {
    List<Doctor> items = <Doctor>[];
    items.add(
        Doctor(
          "Doctor 1",
        )
    );
    items.add(
        Doctor(
          "Doctor 2",
        )
    );
    return items;
  }


}

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

class PatientPage extends StatefulWidget {
  final Patient item;
  PatientPage({Key key, this.item}) : super(key: key);
  @override
  _PatientPage createState() => _PatientPage(item: this.item);

}

class _PatientPage extends State<PatientPage> {
  final Patient item;
  _PatientPage({Key key, this.item}) ;
  final myController = TextEditingController();
  int _selectedDoctor = 0;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Fill this out in the next step.
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Name of patient: "),
                Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Symptoms: "),
                Text(this.item.description, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Forward to: "),
                new DropdownButton(
                  hint: new Text('Select Doctor'),
                  items: <String>['Doctor1', 'Doctor2', 'Doctor3', 'Doctor4']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDoctor = value;
                    });
                  },
                  isExpanded: true,
                ),
                Text("Comments: "),
                TextField(
                  controller: myController,
                ),

              ],
            )
        )

      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing
        // the text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text("Sent to Doctor2\n" +"Comment : " + myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.send),
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
                            Text(this.item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),

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


