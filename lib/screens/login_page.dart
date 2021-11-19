import 'dart:convert';
import 'dart:developer';

import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

import 'screens_export.dart';
import "dart:developer" as dev;

class LoginPage extends StatefulWidget {
  static const String loginPageId = "LoginPage";
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usertextcrl = TextEditingController();
  final TextEditingController passwordctr = TextEditingController();
  bool _isloading = false;
  bool vis = true;
  // ignore: non_constant_identifier_names
  final _GlobalKey = GlobalKey<FormState>();
  HttpHelper httphelper = HttpHelper();

  set isloading(bool value) {
    setState(() {
      _isloading = value;
    });
  }

  void signin() async {
    try {
      Map<String, String> data = {
        "username": usertextcrl.text,
        "password": passwordctr.text
      };
      var response = await httphelper.post("/login", data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Map<String, dynamic> output = json.decode(response.body);
        // ignore: avoid_print
        log(output.toString());

        UserPreferences.token = output["token"];
        UserPreferences.uuid = output["uuid"];
        setState(() {
          _isloading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      } else {
        dev.log("username incorect");
      }
    } finally {
      isloading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // ignore: prefer_const_literals_to_create_immutables
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 120),
          child: Form(
            key: _GlobalKey,
            child: Column(
              children: [
                Text(
                  "Login",
                  style: GoogleFonts.openSans(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'User Name',
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        color: Color(0xFF6CA8F1),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      height: 60.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "user nama must not be a Empty";
                          }
                          if (value.length <= 3) {
                            return "user name must be >3";
                          }
                          return null;
                        },
                        controller: usertextcrl,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 14.0),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your user name ',
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Password',
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        // ignore: prefer_const_constructors
                        color: Color(0xFF6CA8F1),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.centerLeft,
                      height: 60.0,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password must not be a Empty";
                          }
                          if (value.length <= 3) {
                            return "password must be >3";
                          }
                          return null;
                        },
                        controller: passwordctr,
                        obscureText: vis,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              vis ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                vis = !vis;
                              });
                            },
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(top: 14.0),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.white,
                          ),
                          hintText: 'Enter your Password',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 5.0,
                        onPressed: () => {
                          if (_GlobalKey.currentState!.validate())
                            {
                              if (!_isloading) {signin()}
                            }
                        },

                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.all(15.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: Colors.white,
                        // ignore: prefer_const_constructors
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (_isloading)
                              const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 1.5,
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                    const Divider(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RegisterPage.registerPageId),
                      child: RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'Don\'t have an Account? ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
