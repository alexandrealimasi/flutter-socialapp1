import 'package:social_app1/models/models_export.dart';
import 'package:social_app1/screens/screens_export.dart';

class ReceverMessage extends StatelessWidget {
  static const String receverMessageId = "ReceverMessage";
  const ReceverMessage({
    Key? key,
    required this.messageModel,
  }) : super(key: key);
  final MessageModel? messageModel;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.green[100],
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 30, bottom: 30),
                  child: Text(
                    "${messageModel?.message}",
                    style: GoogleFonts.lato(fontSize: 18),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  right: 19,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("${messageModel?.createdAt}"),
                      const SizedBox(
                        width: 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
