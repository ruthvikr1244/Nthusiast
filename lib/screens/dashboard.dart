import 'package:flutter/material.dart';
import 'package:nthusiast/screens/clubs_page.dart';

class dashboard extends StatelessWidget {
  const dashboard({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(colors: [
      Colors.purple, Colors.blue
      // Color.fromARGB(1, 194, 98, 205),
      // Color.fromARGB(1, 4, 79, 171)
    ]);

    final cardHeight = MediaQuery.of(context).size.width / 2;
    final cardWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        padding: const EdgeInsets.all(18),
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.fromLTRB(10, 50, 0, 20),
                  child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return gradient.createShader(Offset.zero & bounds.size);
                      },
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          'Good Evening,',
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontFamily: 'Lalezar',
                          ),
                        ),
                      ))),
              Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Container(
                      height: cardHeight,
                      width: cardWidth,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        clubs(title: 'clubs')));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Color.fromARGB(174, 73, 189, 63),
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  20, cardHeight - 70, 20, 0),
                              child: Text(
                                "Clubs",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 35,
                                    fontFamily: 'Lalezar'),
                              ),
                            ),
                          )))),
              Container(
                  height: cardHeight,
                  width: cardWidth,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Color.fromARGB(255, 121, 132, 228),
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, cardHeight - 70, 20, 0),
                      child: Text(
                        "Other Links",
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Lalezar'),
                      ),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
