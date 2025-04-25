import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyer_mart1/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isloading = false.obs;

  //text controller
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //LogIn Method
  Future<UserCredential?> loginMethod({context}) async{
    UserCredential? userCredential;
    try {
      await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Sign up Method
   Future<UserCredential?> signupMethod({email, password, context}) async{
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //Storing Data Method
  storeUserData({name, password, email}) async{
    DocumentReference store = firestore.collection(usersCollection).doc(currentUser?.uid);
    store.set({'name': name, 'password' : password, 'email': email, 'imageurl':'', 'id': currentUser!.uid, 'cart_count': "00", 'wishlist_count': "00", 'order_count': "00"});
  }

  //Signout Method
  signoutMethod(context) async{
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}