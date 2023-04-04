import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nthusiast/screens/posts_page.dart';

class clubs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference clubCategories =
        FirebaseFirestore.instance.collection("assets");

    return Scaffold(
      body: CustomPaint(
          painter: bgPainter(),
          child: StreamBuilder<QuerySnapshot>(
            stream: clubCategories.snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Not Today buddy...");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading.....");
              }

              return Stack(
                children: <Widget>[
                  const Padding(
                      padding: EdgeInsets.fromLTRB(25, 45, 0, 0),
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
                      padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: expansionTileGenerator(
                              snapshot.data!.docs[0]["category"]),
                        ),
                      ))
                ],
              );
            }),
          )),
    );
  }
}

List<SingleChildScrollView> expansionTileGenerator(List<dynamic> data) {
  List<SingleChildScrollView> lst = [];

  data.map((x) {
    lst.add(SingleChildScrollView(
      child: ExpansionTile(
        title: Text(
          x.toString(),
          style: const TextStyle(
              fontFamily: "Inter", fontWeight: FontWeight.w700, fontSize: 18),
        ),
        children: clubCardGenerator(x.toString()),
      ),
    ));
  }).toList();

  return lst;
}

List<Widget> clubCardGenerator(String cat) {
  Query<Map<String, dynamic>> clubs = FirebaseFirestore.instance
      .collection("clubs")
      .where("category", isEqualTo: cat);

  return [
    StreamBuilder<QuerySnapshot>(
        stream: clubs.snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return const Text("There appears to be an error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading.....");
          }

          int clubsCount = snapshot.data!.docs.length;

          return GridView.builder(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemCount: clubsCount,
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostsPage(
                                docDetails: snapshot.data!.docs[index]),
                          ));
                    },
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15))),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(
                                    snapshot.data!.docs[index]["colour"][0],
                                    snapshot.data!.docs[index]["colour"][1],
                                    snapshot.data!.docs[index]["colour"][2],
                                    snapshot.data!.docs[index]["colour"][3]),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(15))),
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 15),
                                  child: Text(
                                    snapshot.data!.docs[index]["name"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Inter",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ]));
              });
        }))
  ];
}

class bgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xFFF26522)
      ..shader = const LinearGradient(colors: [Colors.purple, Colors.blue])
          .createShader(Rect.fromCircle(
              center: const Offset(100, -150), radius: size.width / 1.5))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(const Offset(120, -150), size.width / 1.5, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
