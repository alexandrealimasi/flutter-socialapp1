import 'dart:convert';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'dart:developer' as dev;

class RegisterPage extends StatefulWidget {
  static const String registerPageId = "RegisterPage";

  const RegisterPage({Key? key}) : super(key: key);
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  HttpHelper httphelper = HttpHelper();
  bool isloading = true;
  void singup() async {
    try {
      Map<String, String> data = {
        "name": nameController.text,
        "postname": postnameController.text,
        "age": ageController.text,
        "gender": genderController.text,
        "phone": phoneController.text,
        "country": countryController.text,
        "username": usernameController.text,
        "password": passwordController.text,
      };
      var response = await httphelper.post("/register", data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: unused_local_variable
        Map<String, dynamic> output = json.decode(response.body);
        setState(() {
          isloading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
            (route) => false);
      } else {
        dev.log("username incorect");
      }
    } finally {
      isloading = true;
    }
  }

  bool vis = true;

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController postnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool circle = false;
  final _globalkey = GlobalKey<FormState>();
  bool validate = false;
  String errorText = '';
  Widget _buildNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Name',
          style: GoogleFonts.lato(),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color(0xFF6CA8F1),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextFormField(
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return ("name must not be a Empty");
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your Name',
              hintStyle: GoogleFonts.openSans(color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPostNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'PostName',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: postnameController,
            validator: (value) {
              if (value!.isEmpty) {
                return ("PostName must not be a Empty");
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your PostName',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Phone Number',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: phoneController,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Phone Number must not be a Empty");
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your phone Number',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgeTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Age',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: ageController,
            validator: (value) {
              if (value!.isEmpty) {
                return ("Age must not be a Empty");
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.number,
            style: GoogleFonts.openSans(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your Age',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCountryTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Country',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: countryController,
            validator: (value) {
              if (value!.isEmpty) {
                return ("country must not be a Empty");
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.map_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter your Country',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserNameTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'User Name',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: usernameController,
            validator: (value) {
              if (value!.isEmpty) return "username must not be a Empty";
              if (value.length <= 5) return "username must be >5";
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter your User Name',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Gender',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: genderController,
            validator: (value) {
              if (value!.isEmpty) return "Gender must not be a Empty";
              if (!value.contains("M,F")) return ('Invalid Gender');
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.white,
              ),
              hintText: 'Enter your Email',
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: GoogleFonts.openSans(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
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
          height: 60.0,
          child: TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) return "Password must not be a Empty";
              if (value.length <= 4) return "password must be >4";
              return null;
            },
            obscureText: vis,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
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
              hintStyle: GoogleFonts.openSans(
                color: Colors.white54,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      // ignore: deprecated_member_use
      child: MaterialButton(
        onPressed: () {
          setState(() {
            isloading = true;
          });
          return singup();
        },
        elevation: 5.0,
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: circle
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Text(
                'LOGN UP',
                style: TextStyle(
                  color: Color(0xFF527DAA),
                  letterSpacing: 1.5,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSans',
                ),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              SizedBox(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Form(
                    key: _globalkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        _buildNameTF(),
                        const SizedBox(
                          height: 30.0,
                        ),
                        _buildPostNameTF(),
                        _buildGenderTF(),
                        _buildAgeTF(),
                        _buildPhoneTF(),
                        _buildCountryTF(),
                        _buildUserNameTF(),
                        _buildPasswordTF(),
                        _buildSignUpBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // checkUser() async {
  //   if ((usernameController.text).isEmpty) {
  //     setState(() {
  //       circle = false;
  //       validate = false;
  //       dev.log("Username Can't be empty");
  //     });
  //   } else {
  //     var response =
  //         await httphelper.get("/checkusername/${usernameController.text}");
  //     if (response['Status']) {
  //       setState(() {
  //         circle = false;
  //         validate = false;
  //         dev.log("Username already taken");
  //       });
  //     } else {
  //       setState(() {
  //         circle = false;
  //         validate = true;
  //       });
  //     }
  //   }
  // }
}
