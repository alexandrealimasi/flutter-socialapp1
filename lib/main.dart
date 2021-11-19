import 'package:camera/camera.dart';
import 'package:social_app1/Custom/_camera_screen.dart';
import 'package:social_app1/Pages/Chats/_list_contacts.dart';

import 'package:social_app1/screens/screens_export.dart';

import 'package:social_app1/utils/_shared_preferences.dart';
import 'package:social_app1/utils/_splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();
  // UserPrefecences.init();
  runApp(const MainPage());
  await UserPreferences.init();
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.splashScreenId,
      routes: {
        SplashScreen.splashScreenId: (context) => const SplashScreen(),
        LoginPage.loginPageId: (context) => const LoginPage(),
        RegisterPage.registerPageId: (context) => const RegisterPage(),
        HomePage.homePageId: (context) => const HomePage(),
        PostPage.postPageId: (context) => const PostPage(),
        UsersPage.usersPageId: (context) => const UsersPage(),
        Chats.chatId: (context) => const Chats(),
        ProfilePage.profilePageId: (context) => const ProfilePage(),
        ListContacts.listContactsId: (context) => const ListContacts()
      },
      // home: Chats(),
    );
  }
}
