import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/views/auth_screen/login_screen.dart';
import 'package:seller_mart1/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }
  var isloggedin = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isloggedin = false;
      } else {
        isloggedin = true;
      }
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      home: isloggedin ? const Home() : const LoginScreen(),
      theme: ThemeData(appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0.0)),
    );
  }
}