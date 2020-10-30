import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = auth.FirebaseAuth.instance;

class FirestoreScreen extends StatefulWidget {
  static const String id = 'firestore_screen';

  @override
  _FirestoreScreenState createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('crms').snapshots(),
          builder: (context, snapshot) {
            List<Text> widgets = [];
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            final crms = snapshot.data.docs;
            for (var crm in crms) {
              widgets.add(
                Text(crm.data()['title']),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(8),
              children: widgets,
            );
          },
        ),
      ),
    );
  }
}
