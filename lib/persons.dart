import 'package:flutter/material.dart';
import 'main.dart';

class persons extends StatelessWidget {
  String name;
  String age;
  persons(this.name, this.age);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: Color.fromARGB(255, 3, 113, 132),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            name,
            style: TextStyle(fontSize: 20),
          ),
          Text(
            age,
            style: TextStyle(fontSize: 20),
          ),
        ]),
      ),
    );
  }
}
