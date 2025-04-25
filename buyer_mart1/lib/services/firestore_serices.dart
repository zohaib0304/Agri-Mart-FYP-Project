import 'package:buyer_mart1/consts/consts.dart';

class FirestoreServices {
  //get users data
  static getUser(uid) {
    return firestore.collection(usersCollection).where('id', isEqualTo: uid).snapshots();

  }

  // get products according to category

  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category', isEqualTo: category).snapshots();
    
  }
  // get products according to sub category 
  static getSubCategoryProducts(title) {
    return firestore.collection(productsCollection).where('p_subcategory', isEqualTo: title).snapshots();
  }

  // Get alll Chat Msgs
  static getChatMessages(docId) {
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection).orderBy('created_on', descending: false).snapshots();
  }

  // Get all Messages
  static getAllMessages() {
    return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
  }

  static searchProducts(title) {
    return firestore.collection(productsCollection).get();
  }

  

  // All Products
  /*static allProducts() {
    return firestore.collection(productsCollection).snapshots();
  }*/
}

