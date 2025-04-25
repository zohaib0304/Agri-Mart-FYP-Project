import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "${data['p_name']}", color: green, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                autoPlay: true,
                height: 350,
                itemCount: data['p_imgs'].length, //data['p_imgs'].length,
                aspectRatio: 16/9,
                viewportFraction: 1.0,
                itemBuilder: (context,index){
                  return Image.network(data['p_imgs'][index], width: double.infinity, fit: BoxFit.cover);//data["p_imgs"][index], width: double.infinity,fit: BoxFit.cover,);
                }
              ),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title and details section
                    boldText(text: "${data['p_name']}", color: green, size: 22.0),
                    //title!.text.size(18).color(blackColor).fontFamily(semibold).make(),
                    10.heightBox,
                    Row(
                      children: [
                        boldText(text: "${data['p_category']}", color: green, size: 16.0),
                        10.widthBox,
                        normalText(text: "${data['p_subcategory']}", color: green, size: 16.0),
                      ],
                    ),
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
                    boldText(text: "\$${data['p_price']}", color: green, size: 18.0),
                    //"${data ['p_price']}".text.color(blackColor).fontFamily(bold).size(18).make(),

                    10.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Quantity: ", color: green),
                            ),
                            normalText(text: "${data['p_quantity']} items", color: green),
                          ],
                        ),
                      ],
                    ).box.white.padding(const EdgeInsets.all(8.0)).make(),
                    const Divider(),
                    20.heightBox,
                    boldText(text: "Description", color: green),
                    //"Description".text.color(blackColor).fontFamily(semibold).make(),
                    10.heightBox,
                    normalText(text: "${data['p_desc']}", color: green),
                    //"${data['p_desc']}".text.color(darkFontGrey).make(),
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}