import 'package:flutter/cupertino.dart';
import 'package:social_app1/screens/screens_export.dart';

class PostDetailPage extends StatelessWidget {
  final String title;
  final String image;
  final String time;
  final String descrption;

  const PostDetailPage(
      {Key? key,
      required this.title,
      required this.image,
      required this.time,
      required this.descrption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 8),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Expanded(
                  child: Column(
                children: [
                  ListTile(
                    title: Image(image: NetworkImage(image)),
                    subtitle: Text(time),
                  ),
                  SizedBox(
                    child: Text(
                      title,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.lato(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    descrption,
                    style: GoogleFonts.lato(),
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 68,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            minLines: 1,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type a message",
                              hintStyle: const TextStyle(color: Colors.grey),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.send),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(5),
                            ),
                          ),
                          margin: const EdgeInsets.only(
                              left: 2, right: 2, bottom: 8),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          right: 6,
                          left: 2,
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: const Color(0xFF128C7E),
                          child: IconButton(
                            icon: const Icon(
                              Icons.share,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
