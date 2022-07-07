import 'package:flutter/material.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddChore extends StatefulWidget {
  const AddChore({Key? key}) : super(key: key);

  @override
  State<AddChore> createState() => _AddChoreState();
}

class _AddChoreState extends State<AddChore> {
  String? Todo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text(
            'Add Chore',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(22, 30, 22, 0),
        child: Column(
          children: <Widget>[
            Form(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Enter Chore',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      validator:(value){
                        return value!.isEmpty ? 'Please fill the field':null;
                      },
                        onChanged:(String value){
                          Todo = value;
                        }
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                        style:ElevatedButton.styleFrom(
                          primary:Colors.red,
                        ),
                        onPressed: (){
                          db.collection('todos').add({'name': Todo});
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Chores()));
                        },
                        child:Text('Add'),
                    )
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}
