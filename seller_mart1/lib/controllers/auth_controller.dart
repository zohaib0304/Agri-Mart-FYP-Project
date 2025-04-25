
import 'package:seller_mart1/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var isloading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<User?> loginMethod({required BuildContext context}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return userCredential.user;
    } catch (e) {
      // ignore: avoid_print
      print("Error logging in: $e");
      return null;
    }
  }
  // Future<UserCredential?> loginMethod({context}) async{
  //   UserCredential? userCredential;
  //   try {
  //     userCredential = 
  //         await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  //   return userCredential;
  // }


  //Signout Method
  signoutMethod(context) async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}