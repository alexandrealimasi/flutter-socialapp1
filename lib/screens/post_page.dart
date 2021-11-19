import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/painting.dart';
import 'package:social_app1/Pages/Posts/_add_posts.dart';
import 'package:social_app1/models/post.dart';

import 'package:social_app1/screens/screens_export.dart';
import 'package:social_app1/services/http/http_helper.dart';
import 'package:social_app1/shared/widgets/Posts/Post_Category/_all_post.dart';

import 'package:social_app1/shared/widgets/Posts/topbar.dart';
import 'package:social_app1/utils/_shared_preferences.dart';

class PostPage extends StatefulWidget {
  static const String postPageId = "PostPage";
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getPost();
    // tabController = TabController(length: menuItems.length, vsync: this);
    super.initState();
  }

  bool circular = true;
  HttpHelper httpHelper = HttpHelper();
  final List<Post> postlist = [];

  getPost() async {
    var response = await httpHelper
        .get("/getposts?Authorization=Bearer ${UserPreferences.token}");
    (response["post"] as List).forEach((item) {
      return postlist.add(Post.fromJson(item));
    });
    setState(() {
      circular = false;
    });
  }

  TabController? tabController;

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return circular
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddPost(),
                    ));
              },
              child: const Icon(Icons.post_add),
            ),
            body: postlist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.post_add_outlined,
                            size: 80, color: Colors.grey.shade200),
                        const Text('No data found')
                      ],
                    ),
                  )
                : SafeArea(
                    child: SizedBox(
                        width: size.width,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              CarouselSlider.builder(
                                itemCount: postlist.length,
                                itemBuilder: (context, index, realIndex) {
                                  return Card(
                                      elevation: 0,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  "${postlist[index].picture}"),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          ),
                                          Text("${postlist[index].title}")
                                        ],
                                      ));
                                },
                                options: CarouselOptions(
                                    aspectRatio: 30 / 20,
                                    viewportFraction: 0.8,
                                    initialPage: 0,
                                    reverse: false,
                                    enableInfiniteScroll: true,
                                    autoPlayCurve: Curves.bounceInOut,
                                    scrollDirection: Axis.horizontal,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3),
                                    autoPlayAnimationDuration:
                                        const Duration(microseconds: 8000)),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                color: Colors.teal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Posts",
                                      style: GoogleFonts.laila(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: postlist.length,
                                  itemBuilder: (context, index) {
                                    return AllPosts(
                                        title: "${postlist[index].title}",
                                        image: "${postlist[index].picture}",
                                        time: "${postlist[index].date}",
                                        descrption:
                                            "${postlist[index].description}");
                                  }),
                            ],
                          ),
                        )),
                  ),
          );
  }
}

class PostIterm extends StatefulWidget {
  const PostIterm({Key? key, required this.pic, required this.title})
      : super(key: key);
  final String pic;
  final String title;

  @override
  State<PostIterm> createState() => _PostItermState();
}

class _PostItermState extends State<PostIterm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(widget.pic),
                height: 250,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xCC000000),
                      Color(0x00000000),
                      Color(0x00000000),
                      Color(0xCC000000),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
