import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/products_controller.dart';
import 'package:seller_mart1/services/store_services.dart';
import 'package:seller_mart1/views/products_screen/add_product.dart';
import 'package:seller_mart1/views/products_screen/product_details.dart';
import 'package:seller_mart1/views/widgets/appbar_widget.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

class ProductsScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ProductsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: green,
        onPressed: () async {
          await controller.getCategories();
          Get.to(() => const AddProduct());
        },
        child: const Icon(Icons.add, color: white),
      ),
      appBar: appbarWidget(products),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            final data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length, (index) => Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(data: data[index]));
                        },
                        leading: Image.network(data[index]['p_imgs'][0], width: 70, height: 70, fit: BoxFit.cover),
                        title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: Row(
                          children: [
                            normalText(text: "${data[index]['p_price']}", color: darkGrey, size: 6),
                            const SizedBox(width: 5),
                            //boldText(text: data[index]['is_topproduct'] == true ? "Top Product": '', color: green)
                          ],
                        ),
                        trailing: VxPopupMenu(
                          arrowSize: 0.0,
                          menuBuilder: () => Column(
                            children: List.generate(
                              popupMenuTitles.length, (i) => Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      popupMenuIcons[i],
                                      //color: data[index]['topproduct_id'] == currentUser!.uid && i==0 ? green : black,
                                    ),
                                    const SizedBox(width: 10),
                                    //data[index]['topproduct_id'] == currentUser!.uid && i==0 ? 'Remove TP' : 
                                    normalText(text: popupMenuTitles[i], color: darkGrey),
                                  ],
                                ).onTap(() {
                                  switch (i) {
                                    case 0:
                                      controller.removeProduct(data[index].id);
                                      VxToast.show(context, msg: "Product Removed");
                                      //controller.editProduct(data[index].id, context);
                                      //VxToast.show(context, msg: "Product Updated");

                                      /*if (data[index]['is_topproduct'] == true) {
                                        controller.removeTopproduct(data[index].id);
                                        VxToast.show(context, msg: "Removed");
                                      } else {
                                        controller.addTopproduct(data[index].id);
                                        VxToast.show(context, msg: "Added");
                                      }
                                      //controller.editProduct(data[index].id, context);
                                      //VxToast.show(context, msg: "Product Updated");*/
                                      break;
                                    default:
                                  }
                                }),
                              )
                            ),
                          ).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick,
                          child: const Icon(Icons.more_vert_rounded),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      )
    );
  }
}
