import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class signup extends StatefulWidget {
  @override
  signupState createState() => signupState();
}

class signupState extends State<signup> {
  final namecont = TextEditingController();
  final passcont = TextEditingController();
  final confirmpasscont = TextEditingController();
  List<String> usernamedata = [];
  List<String> passdata = [];
  bool flag = true;
  bool confirmflag = true;
  bool confirmed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "signup",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 3, 113, 132)),
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your username',
                  hintText: 'username'),
              controller: namecont,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: flag,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
                hintText: 'Password',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      flag = !flag;
                    });
                  },
                  child: Icon(Icons.remove_red_eye_outlined),
                ),
              ),
              controller: passcont,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: confirmflag,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'confirm your Password',
                hintText: 'Enter your password again',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      confirmflag = !confirmflag;
                    });
                  },
                  child: Icon(Icons.remove_red_eye_outlined),
                ),
              ),
              controller: confirmpasscont,
            ),
            MaterialButton(
              onPressed: () {
                (confirmpasscont.text == passcont.text)
                    ? confirmed = true
                    : confirmed = false;
                usernamedata.add(namecont.text);
                passdata.add(passcont.text);
                savedata("users", usernamedata);
                savedata("pass", passdata);
                print("done");
                setState(() {
                  if (confirmed) {
                    Navigator.pushNamed(
                      context,
                      "/home",
                    );
                    /*usernamedata.add(namecont.text);
                    passdata.add(passcont.text);
                    savedata("users", usernamedata);
                    savedata("pass", passdata);*/
                  } else {
                    Alert(
                            context: context,
                            title: "Error",
                            desc: "Passwords aren't The Same")
                        .show();
                  }
                });
              },
              color: Color.fromARGB(255, 3, 113, 132),
              child: Text(
                "signup",
                style: TextStyle(color: Color.fromARGB(255, 244, 246, 255)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

savedata(String key, List<String> data) async {
  final pref = await SharedPreferences.getInstance();
  print("de77k");
  pref.setStringList(key, data);
}
