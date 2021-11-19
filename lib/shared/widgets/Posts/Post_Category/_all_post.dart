import 'package:social_app1/screens/screens_export.dart';

import '../_post_detail.dart';

class AllPosts extends StatefulWidget {
  final String? title;
  final String? image;
  final String? time;
  final String? descrption;

  const AllPosts(
      {Key? key,
      required this.title,
      required this.image,
      required this.time,
      required this.descrption})
      : super(key: key);

  @override
  _AllPostsState createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PostDetailPage(
                descrption: "${widget.descrption}",
                image: '${widget.image}',
                time: '${widget.time}',
                title: '${widget.title}',
              ),
            ));
      },
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: Image.network(
                  "${widget.image}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ("${widget.title}"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${"${widget.descrption}".length <= 200 ? ("${widget.descrption}".length / 200).floor() : ("${widget.descrption}".length / 200 * 60).floor()} ${"${widget.descrption}".length >= 200 ? "mins" : "secs"} read",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                        Text(
                          "${widget.time}",
                          style:
                              TextStyle(fontSize: 13, color: Colors.grey[700]),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
