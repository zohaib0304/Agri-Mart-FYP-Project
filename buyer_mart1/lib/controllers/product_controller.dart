
import 'package:buyer_mart1/Models/category_models.dart';
import 'package:buyer_mart1/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var totalPrice = 0.obs;

  var subcat = [];

  var isFav = false.obs;
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity( ) {
    if (quantity.value > 0){
      quantity.value--;
    }
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, sellername, qty, tprice, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'sellername': sellername,
      'qty': qty,
      'tprice': tprice,
      'added by': currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    }
    );
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    
  }

  /*addToWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
  }

  removeFromWishlist(docId) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
  }*/
}