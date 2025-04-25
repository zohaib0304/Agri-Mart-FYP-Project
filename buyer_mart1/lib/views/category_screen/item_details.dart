

import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/consts/list.dart';
import 'package:buyer_mart1/controllers/product_controller.dart';
import 'package:buyer_mart1/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());
    // ignore: deprecated_member_use
    return WillPopScope(onWillPop: () async{
      controller.resetValues();
      return true;
    },
    child: Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.resetValues();
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share,)),
          /*IconButton(onPressed: () {
            if (controller.isFav.value) {
              controller.removeFromWishlist(data.id);
              controller.isFav(false);
            } else {
              controller.addToWishlist(data.id);
              controller.isFav(true);
            }
          }, icon: const Icon(Icons.favorite_outlined,)),*/
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // swiper section
                    VxSwiper.builder(
                      autoPlay: true,
                      height: 350,
                      itemCount: data['p_imgs'].length,
                      aspectRatio: 16/9,
                      viewportFraction: 1.0,
                      itemBuilder: (context,index){
                        return Image.network(data["p_imgs"][index], width: double.infinity,fit: BoxFit.cover,);
                      }
                    ),

                    10.heightBox,
                    //title and details section
                    title!.text.size(18).color(blackColor).fontFamily(semibold).make(),
                    10.heightBox,
                    //rating
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value){},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      maxRating: 5,
                      count: 5,
                      size: 25,
                    ),

                    10.heightBox,
                    "${data['p_price']}".text.color(blackColor).fontFamily(bold).size(18).make(),

                    10.heightBox,


                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Seller".text.black.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                            ],
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded, color: blackColor),
                        ).onTap(() {
                          Get.to(
                            () => const ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']],
                          );
                        })
                      ],
                    ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                    //color section
                    20.heightBox,
                    Column(
                      children: [
                        /*Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: "Color: ".text.color(blackColor).fontFamily(bold).make(),
                            ),
                            Row(
                              children: List.generate(
                                3, (index) => VxBox().size(40,40).roundedFull.color(Vx.randomPrimaryColor).margin(const EdgeInsets.symmetric(horizontal: 4)).make(),
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),*/

                        // Quantity Row
                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: "Quantity: ".text.size(15).color(blackColor).fontFamily(bold).make(),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  IconButton(onPressed: (){
                                    controller.decreaseQuantity();
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                  }, icon: const Icon(Icons.remove)),
                                  controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                                  IconButton(onPressed: (){
                                    controller.increaseQuantity(int.parse(data['p_quantity']));
                                    controller.calculateTotalPrice(int.parse(data['p_price']));
                                  }, icon: const Icon(Icons.add)),
                                  10.widthBox,
                                  "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                ],
                              ),
                            ),
                          ],
                        )..box.padding(const EdgeInsets.all(8)).make(),

                        // Total Row

                        Row(
                          children: [
                            SizedBox(
                              width: 70,
                              child: "Total: ".text.size(16).color(blackColor).make(),
                            ),
                            "${controller.totalPrice.value}".numCurrency.text.color(blackColor).size(16).fontFamily(semibold).make(),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),

                        //Description Section
                        10.heightBox,
                        "Description".text.color(blackColor).fontFamily(semibold).make(),
                        10.heightBox,
                        "${data['p_desc']}".text.color(darkFontGrey).make(),

                        //Button Section
                        10.heightBox,
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(
                            itemDetailButtonsList.length, (index) => ListTile(
                              title: itemDetailButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                              trailing: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ),
                        20.heightBox,

                        //Products you may like section
                        productsyoumaylike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          /*SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              color: green, onTap: () {
                Get.to(()=>ChatwithUs());
                /*controller.addToCart(
                  context: context,
                  img: data['p_imgs'][0],
                  qty: controller.quantity.value,
                  sellername: data['p_seller'],
                  title: data['p_name'],
                  tprice: controller.totalPrice.value,
                );*/
                //VxToast.show(context, msg: "Added to Cart");
              }, textColor: blackColor, title: "Chat wirh us!"
            ),
          ),*/
        ],
      ),
    ),
    );
  }
}