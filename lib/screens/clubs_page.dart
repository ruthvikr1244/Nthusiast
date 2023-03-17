import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nthusiast/screens/posts_page.dart';

class ClubCard {
  String name;
  String colour;

  ClubCard(this.name, this.colour);
}

class clubs extends StatelessWidget {
  var clubNames = [];

  var clubColors = [];

  @override
  Widget build(BuildContext context) {
    CollectionReference clubs = FirebaseFirestore.instance.collection('clubs');

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
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25, 27, 0, 0),
                            child: Text(
                              'Clubs',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontFamily: 'DoppioOne',
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 140, 0, 5),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount: clubsCount,
                              padding: const EdgeInsets.all(8),
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
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      width: (((MediaQuery.of(context)
                                                  .size
                                                  .width) /
                                              2) -
                                          15),
                                      height: 50,
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 140, 10, 10),
                                          child: Text(
                                            snapshot.data!.docs[index]["name"],
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontFamily: 'DoppioOne'),
                                          )),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
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
