import 'package:flutter/material.dart';
import 'package:studentdb/DBHelper.dart';
import 'package:studentdb/student.dart';

class StudentsData extends StatefulWidget {
  StudentsData({Key? key}) : super(key: key);

  @override
  _StudentsDataState createState() => _StudentsDataState();
}

class _StudentsDataState extends State<StudentsData> {
  @override
  bool dataflag = true;
  List<Students> getStudent = [];

  void initState() {
    numofElements();
  }

  deleteStudent(int id) async {
    DBHelper DB = new DBHelper();
    await DB.deleteStudents(id);
    List<Students> _getStudent = await DB.getAllStudentss();
    setState(() {
      getStudent = _getStudent;
      (getStudent.length == 0) ? dataflag = true : dataflag = false;
      print(dataflag);
    });
  }

  numofElements() async {
    DBHelper DB = new DBHelper();
    List<Students> _getStudent = await DB.getAllStudentss();
    setState(() {
      getStudent = _getStudent;
      (getStudent.length == 0) ? dataflag = true : dataflag = false;
      print(dataflag);
    });
    print(getStudent);
  }

  @override
  Widget build(BuildContext context) {
    if (dataflag) {
      return Scaffold(
        appBar: AppBar(
          title: Text("students Data"),
        ),
        body: Center(
          child: Image(image: AssetImage("Assets/1.png")),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.pushReplacementNamed(context, "/addEdit", arguments: {
                "add": true,
              });
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
          backgroundColor: Colors.black,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("students Data"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: getStudent
                  .map((s) => Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('${s.id}'),
                            Text('${s.name}'),
                            Text('${s.age}'),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/addEdit",
                                      arguments: {
                                        "add": false,
                                        "id": s.id,
                                        "name": s.name,
                                        "age": s.age,
                                      });
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  deleteStudent(s.id);
                                },
                                icon: Icon(Icons.delete))
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 3, 113, 132),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ))
                  .toList(),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        "D:/engineering/flutter/fluttertasks/studentdb/Assets/black.jpg"),
                    fit: BoxFit.cover)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.pushReplacementNamed(context, "/addEdit", arguments: {
                "add": true,
              });
            });
          },
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
          backgroundColor: Colors.black,
        ),
      );
    }
  }
}
