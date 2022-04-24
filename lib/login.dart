import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class login extends StatefulWidget {
  @override
  loginState createState() => loginState();
}

class loginState extends State<login> {
  final namecont = TextEditingController();
  final passcont = TextEditingController();
  bool seeflag = true;
  bool check = false;
  bool correctData = false;
  int index = 0;
  List<String> users_data = [];
  List<String> pass_data = [];
  getuserdata() async {
    final pref = await SharedPreferences.getInstance();
    users_data = pref.getStringList("users") ?? ["empty"];
  }

  getpassdata() async {
    final pref = await SharedPreferences.getInstance();
    pass_data = pref.getStringList("pass") ?? ["empty"];
  }

  @override
  Widget build(BuildContext context) {
    bool loginpressed = false;
    getuserdata();
    getpassdata();
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 3, 113, 132)),
            ),
            TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  labelText: 'Enter your email',
                  hintText: 'Email'),
              controller: namecont,
            ),
            TextField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: seeflag,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Enter your password',
                hintText: 'Password',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      seeflag = !seeflag;
                      print(seeflag);
                    });
                  },
                  child: Icon(Icons.remove_red_eye_outlined),
                ),
              ),
              controller: passcont,
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  loginpressed = true;
                  if (users_data.any((element) {
                    print("getting names ");
                    if (element == namecont.text) {
                      print("identical names");
                      index = users_data.indexOf(element);
                      if (pass_data[index] == passcont.text) {
                        correctData = true;
                        print("identical passwords");
                      } else {
                        print("passwords not the same");
                      }
                      return correctData;
                    } else {
                      print("names arent the same ");
                      correctData = false;
                      return correctData;
                    }
                  }))
                    ;
                  else {
                    print("can't get names ");
                  }
                  if (correctData) {
                    Navigator.pushNamed(
                      context,
                      "/home",
                    );
                  } else {
                    Alert(
                            context: context,
                            title: "Error",
                            desc: "check your data again or Sign up ")
                        .show();
                  }
                });
              },
              color: Color.fromARGB(255, 3, 113, 132),
              child: Text(
                "Login",
                style: TextStyle(color: Color.fromARGB(255, 244, 246, 255)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Remember Me",
                  style: TextStyle(
                      color: Color.fromARGB(255, 3, 113, 132),
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                Checkbox(
                  value: this.check,
                  onChanged: (check) {
                    setState(() {
                      this.check = check!;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Don't have account"),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.pushNamed(
                        context,
                        "/signup",
                      );
                    });
                  },
                  child: Text(
                    "Register Now",
                    style: TextStyle(
                        color: Color.fromARGB(255, 3, 113, 132),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
