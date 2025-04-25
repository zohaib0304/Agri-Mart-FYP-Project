import 'dart:io';

import 'package:buyer_mart1/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
// import 'package:vxtoast/vxtoast.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isloading = false.obs;
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  // Image change function
  changeImage(BuildContext context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      // ignore: use_build_context_synchronously
      VxToast.show(context, msg: e.toString());
    }
  }

  // Upload image
  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  // Update profile
  updateProfile({name, imgurl}) async {
    // ignore: avoid_print
    print("Name: $name");
    var store = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await store.update({
      'name': name,
      'imageurl': imgurl,
    });
    isloading(false);
  }

  // Change auth password
  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    try {
      await currentUser!.reauthenticateWithCredential(cred);
      await currentUser!.updatePassword(newpassword);
    } catch (error) {
      // ignore: avoid_print
      print(error.toString());
    }
  }
}
