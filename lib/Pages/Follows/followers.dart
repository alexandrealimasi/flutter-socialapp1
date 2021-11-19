import 'package:social_app1/models/_followers.dart' as model;
import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  _FollowersState createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  HttpHelper httpHelper = HttpHelper();
  List<model.Followers> listfollowers = [];
  bool circle = true;
  getfollowed() async {
    var response = await httpHelper
        .get("/followers?Authorization=Bearer ${UserPreferences.token}");
    (response["followers"] as List).forEach((item) {
      return listfollowers.add(model.Followers.fromJson(item));
    });
    setState(() {
      circle = false;
    });
  }

  @override
  void initState() {
    super.initState();
    circle = true;
    getfollowed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: circle
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: ListView.builder(
                itemCount: listfollowers.length,
                itemBuilder: (context, index) {
                  return FollowersItem(
                    username: "${listfollowers[index].user?.username}",
                    profile: "${listfollowers[index].user?.picture}",
                  );
                },
              ),
            ),
    );
  }
}

class FollowersItem extends StatelessWidget {
  const FollowersItem({Key? key, required this.username, required this.profile})
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
