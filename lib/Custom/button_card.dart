import 'package:social_app1/screens/screens_export.dart';

class ButtonCard extends StatelessWidget {
  const ButtonCard({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person_add),
            ),
            trailing: const Text(" "),
            title: Text(
              " Add Contact",
              style: GoogleFonts.lato(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Text(
                  "",
                  style: GoogleFonts.lato(fontSize: 13),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
