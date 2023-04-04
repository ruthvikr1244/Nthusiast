import 'dart:io';

import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:nthusiast/utils/time_formatter.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: Text(
                    data["title"],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Inter', color: Colors.white, fontSize: 30),
                  ),
                ),
                Text(
                  "From " + data["author"],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                      child: Card(
                          elevation: 8,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: ListView(children: [
                              MarkdownBody(
                                  data: data["content"]
                                      .toString()
                                      .replaceAll("~~", "\\\n \\\n")
                                      .replaceAll("~", "\\\n"),
                                  selectable: true,
                                  onTapLink: (text, href, title) => href != null
                                      ? launchUrl(Uri.parse(href),
                                          mode: LaunchMode.externalApplication)
                                      : null),
                              Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: data.data()["attachments"] !=
                                              null
                                          ? <Widget>[
                                              const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 25),
                                                  child: Text(
                                                    "attachments",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontFamily: "Inter",
                                                        fontSize: 15),
                                                  )),
                                              GridView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                  itemCount: data["attachments"]
                                                      .length,
                                                  itemBuilder: ((context, i) {
                                                    final imgName =
                                                        data["attachments"][i];
                                                    return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: GestureDetector(
                                                          onTap: () => {
                                                            fileHandling(
                                                                data["attachments"]
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
                                                              children: [
                                                                const Icon(
                                                                  Icons
                                                                      .attachment,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                Text(
                                                                  imgName.toString().substring(
                                                                      imgName.toString().lastIndexOf(
                                                                              '/') +
                                                                          1,
                                                                      imgName
                                                                          .toString()
                                                                          .lastIndexOf(
                                                                              '.')),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
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
                  timeFormatter(data["time"].toDate())[1],
                  style: const TextStyle(fontFamily: "Inter"),
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
      imageUrl.toString().lastIndexOf('/'), imageUrl.toString().length);

  final appDocDir = await getApplicationDocumentsDirectory();

  final String appDocPath = appDocDir.path;
  final File tempFile = File('$appDocPath/$imageName');
  try {
    await imgRef.writeToFile(tempFile);
    await tempFile.create();
    await OpenFilex.open(tempFile.path);

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$imageName downloaded")));
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error, could not open file")));
  }
}
