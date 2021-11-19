import 'dart:developer';
import 'package:social_app1/Pages/Chats/_individuel_page.dart';
import 'package:social_app1/Pages/Chats/_list_contacts.dart';
import 'package:social_app1/models/_conversation_model.dart';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class Chats extends StatefulWidget {
  const Chats({Key? key}) : super(key: key);
  static const String chatId = "Chats";

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool circle = true;
  HttpHelper httpHelper = HttpHelper();
  List<ConversationModel> conversationlist = [];
  ConversationModel? conversationSource;
  conversation() async {
    var response = await httpHelper
        .get("/conversation/get?Authorization=Bearer ${UserPreferences.token}");
    log(response.toString());
    if (response['conversations'] != null) {
      var listData = response['conversations'];
      listData.forEach((item) {
        return conversationlist.add(ConversationModel.fromjson(item));
      });
    }
    setState(() {
      circle = false;
    });
  }

  @override
  void initState() {
    super.initState();

    conversation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, ListContacts.listContactsId);
          },
          child: const Icon(Icons.chat),
        ),
        body: circle
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : buildConversation());
  }

  Widget buildConversation() {
    if (conversationlist.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.chat_bubble_outline,
                size: 80, color: Colors.grey.shade200),
            const Text('No data found')
          ],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: conversationlist.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividuelPage(
                          conversationModel: conversationlist[index],
                          isfirst: false,
                        ),
                      ));
                },
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${conversationlist[index].receiver.picture}'),
                      radius: 30,
                    ),
                    title: Text(
                      "${conversationlist[index].receiver.name}",
                      style: GoogleFonts.lato(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    subtitle:
                        Text("${conversationlist[index].lastMessage!.message}"),
                    trailing: Text(
                        "${conversationlist[index].lastMessage!.createdAt}")));
          });
    }
  }
}
