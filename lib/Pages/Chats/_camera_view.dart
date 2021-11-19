import 'dart:io';

import 'package:social_app1/screens/screens_export.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key, required this.path}) : super(key: key);
  final String path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.crop_rotate)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.emoji_emotions)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.title)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 350,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }
}
