import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/home_controller.dart';
import 'package:seller_mart1/models/category_models.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class ProductsController extends GetxController {
  var isloading = false.obs;

  // Text Field Controller
  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <Category>[].obs;
  var subcategoryList = <String>[].obs;

  var pImagesLinks = [];
  var pImagesList = RxList<File?>(List.generate(3, (index) => null));
  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;

  // Initialize Firebase and other services as needed

  @override
  void onInit() {
    super.onInit();
    // Initialize services, load initial data, etc.
    getCategories();
  }

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    categoryList.value = cat.categories;
  }

  populateSubcategory(String cat) {
    subcategoryList.clear();
    var data = categoryList.where((element) => element.name == cat).toList();
    if (data.isNotEmpty) {
      subcategoryList.addAll(data.first.subcategory);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print(e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
  try {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      //'is_topproduct': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_desc': pdescController.text,
      'p_name': pnameController.text,
      'p_price': ppriceController.text,
      'p_quantity': pquantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': '5.0',
      'vendor_id': currentUser!.uid,
      //'top_product_id': '',
    });
    isloading(false);
    VxToast.show(context, msg: "Product Uploaded Successfully");
  } catch (e) {
    // Handle any errors that occur during the upload process
    // ignore: avoid_print
    print("Error uploading product: $e");
    VxToast.show(context, msg: "Failed to upload product");
  }
}

  
/*
  editProduct(docId, context) async {
  var store = firestore.collection(productsCollection).doc(docId);
  
  await store.update({
    'p_category': categoryvalue.value,
    'p_subcategory': subcategoryvalue.value,
    'p_imgs': FieldValue.arrayUnion(pImagesLinks),
    'p_desc': pdescController.text,
    'p_name': pnameController.text,
    'p_price': ppriceController.text,
    'p_quantity': pquantityController.text,
    'p_seller': Get.find<HomeController>().username,
    // You might want to implement a mechanism to update ratings
    //'p_rating': '5.0', 
    // If you want to update these fields, you need to pass their new values
    //'vendor_id': currentUser!.uid,
    //'top_product_id': '',
  });

  VxToast.show(context, msg: "Product Updated Successfully");
}


  addTopproduct (docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      //'topproduct_id': currentUser!.uid,
      'is_topproduct': true,
    }, SetOptions(merge: true));
  }

  removeTopproduct (docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      //'topproduct_id': '',
      'is_topproduct': false,
    }, SetOptions(merge: true));
  }
  */

  removeProduct (docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }


}
