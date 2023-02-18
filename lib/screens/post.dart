// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post(
      {Key? key,
      required this.postTitle,
      required this.postContent,
      required this.postTime})
      : super(key: key);

  final String postTitle;
  final String postContent;
  final DateTime postTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        children: <Widget>[
          Text(postTitle),
          Text(postContent),
          Text(postTime.toString())
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
