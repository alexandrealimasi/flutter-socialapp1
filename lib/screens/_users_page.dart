import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_app1/models/models_export.dart';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class UsersPage extends StatefulWidget {
  static const String usersPageId = "UsersPage";
  const UsersPage({Key? key}) : super(key: key);

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUser();
  }

  HttpHelper httpHelper = HttpHelper();
  List<User> userlist = [];
  User? user;
  bool circle = true;
  getAllUser() async {
    var response = await httpHelper
        .get("/showallusers?Authorization=Bearer ${UserPreferences.token}");
    (response["users"] as List).forEach((item) {
      userlist.add(User.fromJson(item));
    });
    setState(() {
      circle = false;
    });
  }

  int? followedId;
  follow() async {
    Map<String, String> data = {"followed_id": followedId.toString()};
    await httpHelper.post(
        "/follow?Authorization=Bearer ${UserPreferences.token}", data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: circle
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: userlist.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("${userlist[index].picture}"),
                    radius: 30,
                  ),
                  title: Text(
                    "${userlist[index].name}",
                    style: GoogleFonts.lato(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1),
                  ),
                  subtitle: Text("${userlist[index].country}"),
                  trailing: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.library_add_check_rounded),
                      label: const Text("Follow")),
                );
              },
            ),
    );
  }
}
