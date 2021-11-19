import 'dart:convert';

import 'package:social_app1/Pages/Chats/_individuel_page.dart';
import 'package:social_app1/models/models_export.dart';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';
import 'dart:developer' as dev;

import '_new_message.dart';

class ListContacts extends StatefulWidget {
  const ListContacts({Key? key, this.user}) : super(key: key);
  static const String listContactsId = "ListContacts";
  final User? user;
  @override
  _ListContactsState createState() => _ListContactsState();
}

class _ListContactsState extends State<ListContacts> {
  @override
  void initState() {
    getAllUser();

    super.initState();
  }

  bool circle = true;
  HttpHelper httpHelper = HttpHelper();
  List<User> listUser = [];
  User? user;
  getAllUser() async {
    var response = await httpHelper
        .get("/showallusers?Authorization=Bearer ${UserPreferences.token}");
    (response["users"] as List).forEach((item) {
      listUser.add(User.fromJson(item));
    });
    setState(() {
      circle = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: circle
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: listUser.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage("${listUser[index].picture}"),
                    ),
                    title: Text("${listUser[index].username}"),
                    subtitle: Text("${listUser[index].phone}"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => IndividuelPage(
                                        isfirst: true,
                                        user: listUser[index],
                                      )));
                        },
                        icon: const Icon(
                          Icons.message,
                          color: Colors.amber,
                        )),
                  );
                }));
  }
}
