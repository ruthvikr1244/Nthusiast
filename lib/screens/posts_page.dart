import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nthusiast/screens/post.dart';
import 'package:nthusiast/utils/time_formatter.dart';

class PostsPage extends StatelessWidget {
  final Stream<QuerySnapshot> _postStream = FirebaseFirestore.instance
      .collection("posts")
      .orderBy("Time", descending: true)
      .snapshots();

  PostsPage({Key? key}) : super(key: key);

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

                  return Stack(children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20, left: 100),
                      child: Text(
                        "Club Title",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "DoppioOne",
                            fontSize: 45,
                            color: Colors.white),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(10, 130, 10, 10),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var text =
                            snapshot.data!.docs[index]["Content"].toString();

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
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 255, 143, 143),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        )),
                                    height: 30,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ["Category"],
                                            style: const TextStyle(
                                                fontFamily: "DoppioOne",
                                                fontSize: 14),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Text(
                                            t,
                                            style: const TextStyle(
                                                fontFamily: "DoppioOne",
                                                fontSize: 14),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 35, left: 10, right: 10, bottom: 20),
                                child: Card(
                                  elevation: 8,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        gradient: LinearGradient(
                                            colors: <Color>[
                                              Color.fromRGBO(239, 40, 40, 0.94),
                                              Color.fromRGBO(255, 0, 0, 0.52)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    width: MediaQuery.of(context).size.width,
                                    height: 150,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]["Title"],
                                          style: const TextStyle(
                                              fontFamily: "DoppioOne",
                                              fontSize: 20),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: Text(
                                            utf8
                                                .decode(base64Url.decode(
                                                    snapshot.data!.docs[index]
                                                        ["Content"]))
                                                .toString(),
                                            overflow: TextOverflow.fade,
                                            style: const TextStyle(
                                                fontFamily: "DoppioOne",
                                                fontSize: 12),
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Align(
                                              alignment: Alignment(1, 1),
                                              child: Text(
                                                "Read More",
                                                style: TextStyle(
                                                    fontFamily: "DoppioOne",
                                                    fontSize: 16),
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
                                      top: 7,
                                      right: 14,
                                      child: Icon(Icons.attach_file, size: 22))
                                  : const SizedBox(
                                      height: 0,
                                      width: 0,
                                    )
                            ],
                          ),
                        );
                      },
                    ),
                  ]);
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

    canvas.drawCircle(Offset(200, -180), size.width / 1.5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
