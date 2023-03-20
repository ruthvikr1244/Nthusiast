import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nthusiast/screens/post.dart';
import 'package:nthusiast/utils/time_formatter.dart';

class PostsPage extends StatelessWidget {
  PostsPage({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance
      .collection("clubs")
      .doc("Abhinaya")
      .collection("posts")
      .orderBy("Time", descending: true)
      .snapshots();

  void redirectToPostPage(context, snapshot, index, text) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Post(
                  data: snapshot.data!.docs[index],
                  length: snapshot.data!.docs.length,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomPaint(
            painter: bgPainter(),
            child: StreamBuilder<QuerySnapshot>(
                stream: _postStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong!");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return Stack(
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.fromLTRB(100, 27, 0, 0),
                          child: Text(
                            'Club Title',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 140, 0, 5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var text = snapshot.data!.docs[index]["Content"]
                                .toString();

                            var t = timeFormatter(
                                snapshot.data!.docs[index]["Time"].toDate())[0];

                            return GestureDetector(
                              onTap: () => redirectToPostPage(
                                  context, snapshot, index, text),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Card(
                                      elevation: 8,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15),
                                      )),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color.fromARGB(
                                                173, 239, 40, 40),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            )),
                                        height: 50,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(
                                                snapshot.data!.docs[index]
                                                    ["Category"],
                                                style: const TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
                                              child: Text(
                                                t,
                                                style: const TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50,
                                        left: 10,
                                        right: 10,
                                        bottom: 20),
                                    child: Card(
                                      elevation: 8,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(0),
                                              topRight: Radius.circular(0),
                                              bottomLeft: Radius.circular(15),
                                              bottomRight:
                                                  Radius.circular(15))),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(0),
                                                topRight: Radius.circular(0),
                                                bottomLeft: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15))),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              snapshot.data!.docs[index]
                                                  ["Title"],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.3,
                                              child: Text(
                                                snapshot.data!
                                                    .docs[index]["Content"]
                                                    .toString(),
                                                overflow: TextOverflow.fade,
                                                style: const TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 12),
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Align(
                                                  alignment: Alignment(1, 1),
                                                  child: Text(
                                                    "Read More",
                                                    style: TextStyle(
                                                        fontFamily: "Inter",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  snapshot.data!.docs[index]
                                          .data()
                                          .toString()
                                          .contains("Attatchments")
                                      ? const Positioned(
                                          top: 10,
                                          right: 20,
                                          child:
                                              Icon(Icons.attach_file, size: 25))
                                      : const SizedBox(
                                          height: 0,
                                          width: 0,
                                        )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  );
                })));
  }
}

class bgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xFFF26522)
      ..shader = const LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(1, 1),
          colors: <Color>[
            Color.fromRGBO(239, 40, 40, 0.94),
            Color.fromRGBO(255, 0, 0, 0.52)
          ]).createShader(
          Rect.fromCircle(center: Offset(0, -150), radius: size.width / 1.5))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(200, -170), size.width / 1.5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
