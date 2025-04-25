
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/services/firestore_serices.dart';
import 'package:buyer_mart1/views/category_screen/item_details.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:buyer_mart1/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {

  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: title!.text.color(blackColor).make(),
        ),
        body: FutureBuilder(
          future: FirestoreServices.searchProducts(title),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Products Found!".text.makeCentered();
            } else {
              var data = snapshot.data!.docs;
              var filtered = data.where((element) => element['p_name'].toString().toLowerCase().contains(title!.toLowerCase())).toList();
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 300
                  ),
                  children: filtered.mapIndexed((currentValue, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        filtered[index]['p_imgs'][0],
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const Spacer(),
                      "${filtered[index]['p_name']}".text.fontFamily(semibold).color(blackColor).make(),
                      10.heightBox,
                      "${filtered[index]['p_price']}".text.color(green).fontFamily(semibold).size(16).make(),
                      10.heightBox,
                    ],
                  ).box.white.outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap(() {
                    Get.to(
                      () => ItemDetails(
                        title: "${filtered[index]['p_name']}",
                        data: filtered[index],
                      )
                    );
                  }),
                  ).toList(),
                ),
              );
            }
            
          },
        ),
      ),
    );
  }
}