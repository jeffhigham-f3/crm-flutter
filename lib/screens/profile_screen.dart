import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:verb_crm_flutter/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            floating: true,
            title: Text("Profile"),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 48,
                child: Text(
                  "JH",
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 24,
                  ),
                ),
                backgroundColor: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: OutlineButton(
                onPressed: () => {
                  Navigator.pop(context),
                },
                child: Text("Sign Out"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
