// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post(
      {Key? key,
      required this.postTitle,
      required this.postContent,
      required this.postTime,
      required this.postAuthor})
      : super(key: key);

  final String postTitle;
  final String postContent;
  final DateTime postTime;
  final String postAuthor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Text(
                    postTitle,
                    style: const TextStyle(
                        fontFamily: 'DoppioOne',
                        color: Colors.white,
                        fontSize: 30),
                  ),
                ),
                Text(
                  "From $postAuthor",
                  style: const TextStyle(
                    fontFamily: 'DoppioOne',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.2,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                        child: Card(
                            elevation: 8,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                postContent,
                                textAlign: TextAlign.left,
                                style: const TextStyle(fontFamily: "DoppioOne"),
                              ),
                            )))),
                Text(
                  postTime.toString(),
                  style: const TextStyle(fontFamily: "DoppioOne"),
                )
              ],
            ),
          )
        ],
      ),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 1),
              colors: <Color>[
            Color.fromRGBO(239, 40, 40, 0.94),
            Color.fromRGBO(255, 0, 0, 0.52)
          ])),
    ));
  }
}
