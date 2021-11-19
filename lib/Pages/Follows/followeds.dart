import 'package:flutter/cupertino.dart';
import 'package:social_app1/models/_followeds.dart' as model;
import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class Followeds extends StatefulWidget {
  static const String followedsId = "Followeds";
  const Followeds({Key? key}) : super(key: key);

  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Followeds> {
  HttpHelper httpHelper = HttpHelper();
  List<model.Followeds> listfollowed = [];
  bool circle = true;
  getfollowed() async {
    var response = await httpHelper
        .get("/followeds?Authorization=Bearer ${UserPreferences.token}");
    (response["followeds"] as List).forEach((item) {
      listfollowed.add(model.Followeds.fromjson(item));
      setState(() {
        circle = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    getfollowed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: circle
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                itemCount: listfollowed.length,
                itemBuilder: (context, index) {
                  return FollowedsItems(
                      username: "${listfollowed[index].user?.username}",
                      profile: "${listfollowed[index].user?.picture}");
                },
              ),
            ),
    );
  }
}

class FollowedsItems extends StatelessWidget {
  const FollowedsItems(
      {Key? key, required this.username, required this.profile})
      : super(key: key);
  final String username;
  final String profile;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(profile),
          radius: 50,
        ),
        Text(username,
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold))
      ],
    );
  }
}
