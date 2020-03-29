import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
   return MaterialApp(
     title: 'PView',
     home: MyHomePage(),
   );
 }
}

class MyHomePage extends StatefulWidget {
 @override
 _MyHomePageState createState() {
   return _MyHomePageState();
 }
}

class _MyHomePageState extends State<MyHomePage> {
 @override
 Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(title: Text('Nearby Hospitals')),
     body: _buildBody(context),
   );
 }

Widget _buildBody(BuildContext context){
	return StreamBuilder<QuerySnapshot>(
		stream: Firestore.instance.collection('Hospitals').snapshots(),
		builder: (context, snapshot){
			return _buildList(context, snapshot.data.documents);
		}
	);
}

 Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
   return ListView(
     padding: const EdgeInsets.only(top: 10.0),
     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
   );
 }


 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
   final record = Hospital.fromSnapshot(data);
   return Padding(
    key: ValueKey(record.name),
     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
     child: Container(
       decoration: BoxDecoration(
         border: Border.all(color: Colors.grey),
         borderRadius: BorderRadius.circular(5.0),
       ),
       child: ListTile(
         title: Text(record.name),
        //  trailing: Text(record.loc.toString()),
         onTap: _pushAppointment,
       ),
     ),
   );
 }
 
 void _pushAppointment(){
		Navigator.of(context).push(
			MaterialPageRoute<void>(
				builder: (BuildContext context) {
//Todo: Design Appointment Page.
          return Scaffold(
						appBar: AppBar(title: Text('Apply for Appointment')),
						// body: ,
					);
				}
			)
		);
 }
}

class Hospital{
	final String name;
	final GeoPoint loc;
  List<DocumentReference> doctors;
  final DocumentReference reference;
  Hospital.fromSnapshot(DocumentSnapshot snapshot)
    : this.name = snapshot.data['name'],
      this.loc = snapshot.data['location'],
      this.doctors = snapshot.data['Doctors'].cast<DocumentReference>(),
      this.reference = snapshot.reference;
}