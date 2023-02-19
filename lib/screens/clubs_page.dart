import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nthusiast/screens/posts_page.dart';

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
        body: CustomPaint(
            painter: bgPainter(),
            child: StreamBuilder<QuerySnapshot>(
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

                    return Stack(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.fromLTRB(25, 27, 0, 0),
                            child: Text(
                              'Clubs',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontFamily: 'Lalezar',
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 140, 0, 5),
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: clubsCount,
                              padding: EdgeInsets.all(8),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PostsPage()),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Container(
                                      width: (((MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              2) -
                                          15),
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: Color.fromARGB(
                                          snapshot.data!.docs[index]["colour"]
                                              [0],
                                          snapshot.data!.docs[index]["colour"]
                                              [1],
                                          snapshot.data!.docs[index]["colour"]
                                              [2],
                                          snapshot.data!.docs[index]["colour"]
                                              [3],
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 140, 10, 10),
                                          child: Text(
                                            snapshot.data!.docs[index]["name"],
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'Lalezar'),
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                })));
  }
}

class bgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xFFF26522)
      ..shader = LinearGradient(colors: [Colors.purple, Colors.blue])
          .createShader(Rect.fromCircle(
              center: Offset(100, -150), radius: size.width / 1.5))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(120, -150), size.width / 1.5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
