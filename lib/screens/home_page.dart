import 'package:flutter/cupertino.dart';

import 'package:social_app1/screens/screens_export.dart';

class HomePage extends StatefulWidget {
  static const String homePageId = "HomePage";
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> widgets = [const PostPage(), const Chats(), const ProfilePage()];

  int currentIndex = 0;

  void updateIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text("Social App",
            style: GoogleFonts.lato(color: Colors.blue),
            textAlign: TextAlign.center),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: const [
          PostPage(),
          UsersPage(),
          Chats(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        child: SizedBox(
          height: 60,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    icon: currentIndex == 0
                        ? const Icon(
                            Icons.post_add,
                            color: Colors.blue,
                          )
                        : const Icon(
                            Icons.post_add_outlined,
                          ),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                      });
                    },
                    icon: currentIndex == 1
                        ? const Icon(
                            Icons.group,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.group_outlined),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                      });
                    },
                    icon: currentIndex == 2
                        ? const Icon(
                            Icons.chat,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.chat_outlined),
                    iconSize: 30,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex = 3;
                      });
                    },
                    icon: currentIndex == 3
                        ? const Icon(
                            Icons.person,
                            color: Colors.blue,
                          )
                        : const Icon(Icons.person_outlined),
                    iconSize: 35,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
