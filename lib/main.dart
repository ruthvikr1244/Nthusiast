import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Inter"),
        home: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
          child: LoginScreen(),
        ) //<--
        );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const dashboard(title: 'dashboard');
        }));
      }
    });

    const purple = Color(0xC262CD);
    const blue = Color(0x044FAB);

    final nameController = TextEditingController();
    final db = FirebaseFirestore.instance;

    final gradient = LinearGradient(colors: [
      Colors.purple, Colors.blue
      // Color.fromARGB(1, 194, 98, 205),
      // Color.fromARGB(1, 4, 79, 171)
    ]);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return gradient.createShader(Offset.zero & bounds.size);
                    },
                    child: Center(
                      child: Text(
                        'Nthusiast',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontFamily: 'Lalezar'),
                      ),
                    ))),
            Padding(
                padding: EdgeInsets.fromLTRB(40, 100, 40, 100),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 3,
                              color: Colors.grey.shade300,
                              offset: Offset(0, 4),
                              blurRadius: 3)
                        ]),
                    child: TextField(
                        maxLines: 1,
                        controller: nameController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Your Name...',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide:
                                    BorderSide(color: Colors.white)))))),
            Container(
                child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return gradient.createShader(Offset.zero & bounds.size);
              },
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text(
                    "Go!",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      final userCredential =
                          await FirebaseAuth.instance.signInAnonymously();
                      print("Signed in with temporary account.");

                      db
                          .collection("users")
                          .add({'name': Text(nameController.text)});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const dashboard(title: 'dashboard')));
                    } on FirebaseAuthException catch (e) {
                      switch (e.code) {
                        case "operation-not-allowed":
                          print(
                              "Anonymous auth hasn't been enabled for this project.");
                          break;
                        default:
                          print("Unknown error.");
                      }
                    }
                  },
                ),
              ),
            )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 170, 0, 10),
                child: Center(
                  child: Text(
                    "If you don't have an account, we'll create one for you!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'Lalezar'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
