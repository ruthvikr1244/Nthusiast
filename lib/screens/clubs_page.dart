import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class clubCard {
  String name;
  String colour;

  clubCard(this.name, this.colour);
}

class clubs extends StatelessWidget {
  clubs({Key? key, required this.title}) : super(key: key);
  final String title;

  var clubNames = [];
  var clubColors = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference clubs = FirebaseFirestore.instance.collection('clubs');

    final gradient = LinearGradient(colors: [
      Colors.purple, Colors.blue
      // Color.fromARGB(1, 194, 98, 205),
      // Color.fromARGB(1, 4, 79, 171)
    ]);

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: clubs.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Not today buddy...");
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading...");
              }

              if (snapshot.hasData) {
                snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<dynamic, dynamic> dataMap =
                      document.data()! as Map<dynamic, dynamic>;
                });
                int clubsCount = snapshot.data!.docs.length;

                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: clubsCount,
                    padding: EdgeInsets.all(8),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            width: (((MediaQuery.of(context).size.width) / 2) -
                                15),
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(dataMap['name'])),
                          ),
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
