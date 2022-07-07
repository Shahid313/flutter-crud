import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    home: Chores(),
  ));
}

final db = FirebaseFirestore.instance;

class Chores extends StatefulWidget {
  const Chores({Key? key}) : super(key: key);

  @override
  State<Chores> createState() => _ChoresState();
}

class _ChoresState extends State<Chores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
        title: Text('Chores', style: TextStyle(color:Colors.white),),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddChore()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 30.0,
              ),
          ),
        ],
    ),

      body: StreamBuilder(
        stream: db.collection('todos').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, int index){
                DocumentSnapshot documentSnapshot = snapshot.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    title: Text(documentSnapshot['name'], style: TextStyle(color: Colors.white),),
                    tileColor: Colors.red,
                    onTap: (){
                      db.collection('todos').doc(documentSnapshot.id).delete();
                    },
                  ),
                );
              }
          );
        }
      ),
    );
  }
}



