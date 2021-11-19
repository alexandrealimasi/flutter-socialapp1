import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:social_app1/Pages/Follows/followeds.dart';

import 'package:social_app1/models/user.dart';
import 'package:social_app1/Pages/Follows/_followers.dart';
import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/Pages/Profile/user_up_date.dart';
import 'package:social_app1/services/http/http_helper.dart';

import 'package:social_app1/utils/_shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  static const String profilePageId = "ProfilePage";
  // ignore: use_key_in_widget_constructors
  const ProfilePage({Key? key}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    userget();

    tabController = TabController(length: list.length, vsync: this);
  }

  @override
  void dispose() {
    // ignore: todo
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  var list = [
    const Tab(
      child: Text("Photo"),
    ),
    const Tab(
      child: Text("Live"),
    ),
    const Tab(
      child: Text("Videos"),
    ),
    const Tab(
      child: Text("Freed"),
    ),
  ];
  // ignore: non_constant_identifier_names
  bool Circular = true;
  HttpHelper httphelper = HttpHelper();
  User? user = User();
  userget() async {
    var response = await httphelper
        .get("/profile?Authorization=Bearer ${UserPreferences.token}");
    user = User.fromJson(response["user"]);

//await.
    setState(() {
      Circular = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatProfile(
                      name: "${user?.name}",
                      postname: "${user?.postname}",
                      age: "${user?.age}",
                      gender: "${user?.gender}",
                      country: "${user?.country}",
                      picture: "${user?.picture}",
                      phone: "${user?.phone}"),
                ));
          },
        ),
        body: Circular
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.message)),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_none)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircleAvatar(
                          maxRadius: 80,
                          backgroundImage: user?.picture == null
                              ? const NetworkImage(
                                  "data:image/jpeg;base64,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")
                              : NetworkImage("${user?.picture}")),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "71.9k",
                                style: GoogleFonts.lato(
                                    letterSpacing: 2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Followers(),
                                        ));
                                  },
                                  icon:
                                      const Icon(Icons.library_add_check_sharp),
                                  label: Text(
                                    "Followers",
                                    style: GoogleFonts.lato(
                                        letterSpacing: 2,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "71.9k",
                                style: GoogleFonts.lato(
                                    letterSpacing: 2,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Followeds(),
                                        ));
                                  },
                                  icon:
                                      const Icon(Icons.library_add_check_sharp),
                                  label: Text(
                                    "Follows",
                                    style: GoogleFonts.lato(
                                        letterSpacing: 2,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Name: ${user!.name}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "postname: ${user!.postname}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "gender: ${user!.gender}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "age: ${user!.age}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "country: ${user!.country}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Phone: ${user!.phone}",
                            style: GoogleFonts.lato(
                                letterSpacing: 2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ));
  }
}
