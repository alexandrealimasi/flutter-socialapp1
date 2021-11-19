import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:developer' as dev;
import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class CreatProfile extends StatefulWidget {
  static const String creatProfileId = "CreateProfile";
  const CreatProfile(
      {key,
      required this.name,
      required this.postname,
      required this.age,
      required this.gender,
      required this.country,
      required this.picture,
      required this.phone})
      : super(key: key);
  final String name;
  final String postname;
  final String age;
  final String gender;
  final String country;
  final String picture;
  final String phone;
  @override
  _CreatProfileState createState() => _CreatProfileState();
}

class _CreatProfileState extends State<CreatProfile> {
  @override
  bool circular = false;
  final _globalkey = GlobalKey<FormState>();
  TextEditingController namectr = TextEditingController();
  TextEditingController postnamectr = TextEditingController();
  TextEditingController genderctr = TextEditingController();
  TextEditingController agectr = TextEditingController();
  TextEditingController countryctr = TextEditingController();
  TextEditingController useramectr = TextEditingController();
  TextEditingController passwordctr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  PickedFile? _imageFile;

  HttpHelper httpHelper = HttpHelper();

  void updateUser() async {
    Map<String, String> data = {
      "name": namectr.text,
      "postname": postnamectr.text,
      "gender": genderctr.text,
      "age": agectr.text,
      "country": countryctr.text,
      "phone": phoneCtr.text
    };
    var response = await httpHelper.patch(
        "/update?Authorization=Bearer ${UserPreferences.token}", data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      json.encode(response.body);
    } else {
      dev.log("not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalkey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: <Widget>[
            imageProfile(),
            const SizedBox(
              height: 20,
            ),
            nameTextField(),
            const SizedBox(
              height: 20,
            ),
            postname(),
            const SizedBox(
              height: 20,
            ),
            gender(),
            const SizedBox(
              height: 20,
            ),
            age(),
            const SizedBox(
              height: 20,
            ),
            country(),
            const SizedBox(
              height: 20,
            ),
            phone(),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: updateUser,
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: circular
                        ? const CircularProgressIndicator()
                        : const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: NetworkImage(widget.picture),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28.0,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: const Text("Camera"),
            ),
            TextButton.icon(
              icon: const Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: const Text("Gallery"),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use, unused_local_variable
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile as PickedFile?;
    });
  }

  Widget nameTextField() {
    return TextFormField(
      controller: namectr,
      validator: (value) {
        if (value!.isEmpty) {
          return "Name can't be empty";
        }

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: widget.name,
        helperText: "Name can't be empty",
        hintText: widget.name,
      ),
    );
  }

  Widget postname() {
    return TextFormField(
      controller: postnamectr,
      validator: (value) {
        if (value!.isEmpty) return "PostName can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: widget.postname,
        helperText: "PostName can't be empty",
        hintText: widget.postname,
      ),
    );
  }

  Widget gender() {
    return TextFormField(
      controller: genderctr,
      validator: (value) {
        if (value!.isEmpty) return "Gender can't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: widget.gender,
        helperText: "F/M",
        hintText: widget.gender,
      ),
    );
  }

  Widget age() {
    return TextFormField(
      controller: agectr,
      validator: (value) {
        if (value!.isEmpty) return "Agecan't be empty";

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        prefixIcon: const Icon(
          Icons.person,
          color: Colors.green,
        ),
        labelText: widget.age,
        helperText: "It can't be empty",
        hintText: widget.age,
      ),
    );
  }

  Widget country() {
    return TextFormField(
      controller: countryctr,
      validator: (value) {
        if (value!.isEmpty) return "Your country";

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: widget.country,
        helperText: "where are you from",
        hintText: widget.country,
      ),
    );
  }

  Widget phone() {
    return TextFormField(
      controller: phoneCtr,
      validator: (value) {
        if (value!.isEmpty) return "phone cant br empty";

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: widget.phone,
        helperText: "your phone number",
        hintText: widget.phone,
      ),
    );
  }

  Widget password() {
    return TextFormField(
      controller: passwordctr,
      validator: (value) {
        if (value!.isEmpty) return "password can't be empty";

        return null;
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.teal,
        )),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        labelText: "password",
        helperText: "your password",
        hintText: "***********",
      ),
    );
  }
}
