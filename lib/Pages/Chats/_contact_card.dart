import 'dart:ui';

import 'package:social_app1/screens/screens_export.dart';

class ContactCard extends StatefulWidget {
  static const String contactCardId = "ContactCard";
  const ContactCard({
    Key? key,
    required this.contact,
    required this.name,
    required this.picture,
  }) : super(key: key);
  final String name;
  final String contact;
  final String picture;

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        leading: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 25,
            child: Image(image: NetworkImage(widget.picture))),
        title: Text(
          widget.name,
          style: GoogleFonts.lato(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.contact,
          style: GoogleFonts.lato(fontSize: 13),
        ),
      ),
    );
  }
}
