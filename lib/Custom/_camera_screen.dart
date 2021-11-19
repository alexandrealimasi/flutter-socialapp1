import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_app1/Pages/Chats/_camera_view.dart';

import 'package:social_app1/screens/screens_export.dart';

List<CameraDescription> camera = [];

class CameraScreen extends StatefulWidget {
  const CameraScreen({
    Key? key,
  }) : super(key: key);
  static const String cameraScreenId = "CameraScreen";
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController? cameraController;
  Future<void>? comeravalue;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cameraController = CameraController(camera[0], ResolutionPreset.high);
    comeravalue = cameraController?.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
            future: comeravalue,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(cameraController!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
        Positioned(
          bottom: 0.0,
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.flash_off,
                          color: Colors.white,
                          size: 28,
                        )),
                    InkWell(
                        onTap: () => takephoto(context),
                        child: const Icon(Icons.panorama_fish_eye,
                            color: Colors.white, size: 30)),
                    InkWell(
                      onTap: () {},
                      child: const Icon(Icons.camera_alt, color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ));
  }

  void takephoto(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.jpeg");
    await cameraController?.takePicture();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraView(
            path: path,
          ),
        ));
  }
}
