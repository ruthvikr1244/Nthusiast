import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection("posts").snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _postStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Scaffold(
            body: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(8),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Center(
                    child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(DateTime.now()
                            .difference(
                                snapshot.data!.docs[index]["Time"].toDate())
                            .toString()),
                        Image.asset("assets/images/Inductions.png",
                            height: 200, width: 100),
                        Text(snapshot.data!.docs[index]["Category"])
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(snapshot.data!.docs[index]["Title"]),
                        SizedBox(
                          height: 50,
                          child: Text(snapshot.data!.docs[index]["Content"]),
                        )
                      ],
                    )
                  ],
                ));
              },
            ),
          );
        });
  }
}
