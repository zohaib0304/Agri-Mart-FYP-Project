import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/views/splash_screens/auth_screen/login_screen.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/home.dart';
import 'package:buyer_mart1/widgets_common/applogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  //create a method to change screen

  changeScreen(){
    Future.delayed(const Duration(seconds: 3), () {
      //using getx
      //Get.to(()=> const LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if(user == null && mounted){
          Get.to(() => const LoginScreen());
        } else{
          Get.to(() => const Home());
        }
      });
    });
  }
  
  @override
  void initState() {
    changeScreen();
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child:Image.asset(icSplashBg, width: 300)),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).black.make(),
            5.heightBox,
            appversion.text.black.make(),
            const Spacer(),
            credits.text.black.fontFamily(semibold).make(),
            30.heightBox,
            // Splash Screen UI is complete
          ],
        ),
      ),
    );
  }
}