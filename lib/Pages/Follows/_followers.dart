import 'package:flutter/cupertino.dart';
import 'package:social_app1/models/models_export.dart' as model;
import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class Followers extends StatefulWidget {
  static const String followersId = "Followers";
  const Followers({Key? key}) : super(key: key);

  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Followers> {
  HttpHelper httpHelper = HttpHelper();
  List<model.Followers> listfollowed = [];
  bool circle = true;
  getfollowed() async {
    var response = await httpHelper
        .get("/followers?Authorization=Bearer ${UserPreferences.token}");
    (response["followers"] as List).forEach((item) {
      listfollowed.add(model.Followers.fromJson(item));
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
                      country: "${listfollowed[index].user?.country}",
                      profile: "${listfollowed[index].user?.picture}");
                },
              ),
            ),
    );
  }
}

class FollowedsItems extends StatelessWidget {
  const FollowedsItems(
      {Key? key,
      required this.username,
      required this.profile,
      required this.country})
      : super(key: key);
  final String username;
  final String country;
  final String profile;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profile),
        radius: 50,
      ),
      title: Text(username,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Text(country,
          style: GoogleFonts.lato(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}
