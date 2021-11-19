import 'package:social_app1/screens/screens_export.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  var list = [
    {
      'name': "Elephant Dream",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ElephantsDream.jpg",
    },
    {
      'name': "Big Buck Bunny",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/BigBuckBunny.jpg",
    },
    {
      'name': "For Bigger Blazes",
      'videoUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
      'thumbnailUrl':
          "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/images/ForBiggerBlazes.jpg"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Text("video player here"),
    );
  }
}

class VideosPlayer extends StatelessWidget {
  const VideosPlayer({Key? key, this.name, this.videoUrl, this.thumbnailUrl})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final name;
  // ignore: prefer_typing_uninitialized_variables
  final videoUrl;
  // ignore: prefer_typing_uninitialized_variables
  final thumbnailUrl;
  @override
  Widget build(BuildContext context) {
    return ListView();
  }
}
