
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/services/store_services.dart';
import 'package:seller_mart1/views/products_screen/product_details.dart';
import 'package:seller_mart1/views/widgets/appbar_widget.dart';
import 'package:seller_mart1/views/widgets/dashboard_button.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: appbarWidget(dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashboardButton(context, title: products, count: "${data.length}",icon: icProducts),
                      dashboardButton(context, title: ratings, count: "${data.length}",icon: icStar),
                    ],
                  ),
                  10.heightBox,
                  const Divider(),
                  10.heightBox,
                  boldText(text: allProduct,color: green, size: 16.0),
                  20.heightBox,
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: List.generate(
                      data.length, (index) => ListTile(
                        onTap: () {
                          Get.to(() => ProductDetails(data: data[index]));
                        },
                        leading: Image.network(data[index]['p_imgs'][0], width: 100, height: 100, fit: BoxFit.cover),
                        title: boldText(text: "${data[index]['p_name']}", color: fontGrey),
                        subtitle: normalText(text: "${data[index]['p_price']}", color: darkGrey),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
      )
    );
  }
}