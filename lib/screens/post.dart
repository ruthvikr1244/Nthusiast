import 'dart:convert';
import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nthusiast/utils/time_formatter.dart';
import 'package:path_provider/path_provider.dart';

class Post extends StatelessWidget {
  const Post({Key? key, required this.data, required this.length})
      : super(key: key);

  final dynamic data;
  final int length;

  // final String postTitle = data["Title"];
  // final String postContent;
  // final DateTime postTime;
  // final String postAuthor;
  // final List<dynamic>? postAttatchment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment(0, 0),
              end: Alignment(1, 1),
              colors: <Color>[
            Color.fromRGBO(239, 40, 40, 0.94),
            Color.fromRGBO(255, 0, 0, 0.52)
          ])),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Text(
                    data["Title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'DoppioOne',
                        color: Colors.white,
                        fontSize: 30),
                  ),
                ),
                Text(
                  "From " + data["Author"],
                  textAlign: TextAlign.center,
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
                            child: ListView(children: [
                              Text(
                                utf8.decode(base64Url.decode(data["Content"])),
                                style: const TextStyle(
                                    fontFamily: "DoppioOne", fontSize: 14),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: data.data()["Attatchments"] !=
                                              null
                                          ? <Widget>[
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 25),
                                                  child: Text(
                                                    "Attatchments",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: "DoppioOne",
                                                        fontSize: 15),
                                                  )),
                                              GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                  itemCount:
                                                      data["Attatchments"]
                                                          .length,
                                                  itemBuilder: ((context, i) {
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: GestureDetector(
                                                          onTap: () => {
                                                            fileHandling(
                                                                data["Attatchments"]
                                                                    [i],
                                                                context)
                                                          },
                                                          child: Card(
                                                            color: const Color
                                                                    .fromARGB(
                                                                255,
                                                                53,
                                                                52,
                                                                52),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const [
                                                                Icon(
                                                                  Icons
                                                                      .attachment,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  "FileName",
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                                  }))
                                            ]
                                          : <Widget>[
                                              const SizedBox(
                                                height: 0,
                                                width: 0,
                                              )
                                            ]))
                            ]),
                          )),
                    )),
                Text(
                  timeFormatter(data["Time"].toDate())[1],
                  style: const TextStyle(fontFamily: "DoppioOne"),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}

Future fileHandling(imageUrl, context) async {
  final imgRef = FirebaseStorage.instance.refFromURL(imageUrl);

  final imageName = imageUrl.toString().substring(
      imageUrl.toString().lastIndexOf('/'),
      imageUrl.toString().lastIndexOf('.'));

  final appDocDir = await getApplicationDocumentsDirectory();

  final String appDocPath = appDocDir.path;
  final File tempFile = File('$appDocPath/$imageName.pdf');
  try {
    await imgRef.writeToFile(tempFile);
    await tempFile.create();
    await OpenFile.open(tempFile.path);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error, could not open file")));
  }

  ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text("$imageName downloaded")));
}
