import 'package:flutter/material.dart';
import 'package:studentdb/DBHelper.dart';
import 'package:studentdb/login.dart';
import 'package:studentdb/signup.dart';
import 'package:studentdb/student.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'retrive.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      title: 'All Data',
      initialRoute: '/login',
      routes: {
        '/home': (context) => StudentsData(),
        '/addEdit': (context) => HomePage(),
        "/login": (context) => login(),
        "/signup": (context) => signup(),
      }));
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final studentcont = TextEditingController();
  final agecont = TextEditingController();
  final IDcont = TextEditingController();
  bool stFlag = false;
  bool ageFlag = false;
  bool IDFlag = false;
  @override
  Widget build(BuildContext context) {
    String SORA = "Add";
    Map<String, dynamic> pusheddata =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (pusheddata['add']) {
      SORA = "Add";
    } else {
      SORA = "edit";
      studentcont.text = pusheddata["name"];
      agecont.text = pusheddata["age"].toString();
      IDcont.text = pusheddata["id"].toString();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 3, 113, 132),
        title: Text("students"),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.format_list_numbered),
                  labelText: 'student ID',
                ),
                controller: IDcont,
                enabled: false,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'student Name',
                ),
                controller: studentcont,
              ),
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.format_list_numbered),
                  labelText: 'student age',
                  focusColor: Color.fromARGB(255, 3, 113, 132),
                ),
                controller: agecont,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        Navigator.pushReplacementNamed(
                          context,
                          "/home",
                        );
                      });
                    },
                    child: Text("cancel"),
                    color: Color.fromARGB(255, 3, 113, 132),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      stFlag = (studentcont.text == "") ? false : true;
                      ageFlag = (agecont.text == "" ||
                              (int.parse(agecont.text).isNaN))
                          ? false
                          : true;
                      if (stFlag && ageFlag) {
                        if (pusheddata["add"]) {
                          DBHelper DB = new DBHelper();
                          int inseted = await DB.insertStudents(Students(
                              0, studentcont.text, int.parse(agecont.text)));
                          print(inseted);
                          Navigator.pushReplacementNamed(
                            context,
                            "/home",
                          );
                        } else {
                          DBHelper DB = new DBHelper();
                          await DB.updateStudents(Students(
                              int.parse(IDcont.text),
                              studentcont.text,
                              int.parse(agecont.text)));
                          Navigator.pushReplacementNamed(
                            context,
                            "/home",
                          );
                        }
                      } else {
                        Alert(
                          context: context,
                          title: "Error",
                          desc: "Empty fields",
                        ).show();
                      }
                    },
                    child: Text(SORA),
                    color: Color.fromARGB(255, 3, 113, 132),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
