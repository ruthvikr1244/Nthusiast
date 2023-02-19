import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nthusiast/screens/post.dart';

class PostsPage extends StatelessWidget {
  final Stream<QuerySnapshot> _postStream =
      FirebaseFirestore.instance.collection("posts").snapshots();

  PostsPage({Key? key}) : super(key: key);

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

                  return ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(10, 130, 10, 10),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var text =
                          snapshot.data!.docs[index]["Content"].toString();

                      return SizedBox(
                          height: MediaQuery.of(context).size.width / 1.7,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: <Widget>[
                                  Card(
                                      elevation: 8,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment(0, 0),
                                                  end: Alignment(1, 1),
                                                  colors: <Color>[
                                                    Color.fromRGBO(
                                                        239, 40, 40, 0.94),
                                                    Color.fromRGBO(
                                                        255, 0, 0, 0.52)
                                                  ]),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15))),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Placeholder(
                                                    fallbackHeight: 100,
                                                    fallbackWidth: 100,
                                                  ),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 20, 0, 0),
                                                      child: Text(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ["Category"],
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                "DoppioOne",
                                                            fontSize: 18,
                                                            color:
                                                                Colors.white),
                                                      ))
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: Text(
                                                      snapshot.data!.docs[index]
                                                          ["Title"],
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'DoppioOne',
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height: 100,
                                                      width: 200,
                                                      child: Text(
                                                        text,
                                                        overflow:
                                                            TextOverflow.fade,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'DoppioOne',
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                      )),
                                                  Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          100, 0, 0, 0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Post(
                                                                    postTitle: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        [
                                                                        "Title"],
                                                                    postContent:
                                                                        text,
                                                                    postAuthor: snapshot
                                                                            .data!
                                                                            .docs[index]
                                                                        [
                                                                        "Author"],
                                                                    postTime: snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                            ["Time"]
                                                                        .toDate())),
                                                          );
                                                        },
                                                        child: const Text(
                                                          "Read More",
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DoppioOne',
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ))
                                                ],
                                              )
                                            ],
                                          ))),
                                  const Positioned(
                                      top: 10,
                                      right: 15,
                                      child: Icon(Icons.attach_file, size: 18)),
                                  const Positioned(
                                      top: 10,
                                      left: 20,
                                      child: Text("21w",
                                          style: TextStyle(
                                            fontFamily: "DoppioOne",
                                          ))),
                                ],
                              )));
                    },
                  );
                })));
  }
}

class bgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xFFF26522)
      ..shader = LinearGradient(
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
