import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/consts/list.dart';
import 'package:buyer_mart1/controllers/product_controller.dart';
import 'package:buyer_mart1/views/category_screen/category_details.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: categories.text.fontFamily(bold).black.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8, mainAxisExtent: 200), itemBuilder: (context,index) {
            return Column(
              children: [
                Image.asset(categoryImages[index], height: 120, width: 200, fit: BoxFit.cover,),
                10.heightBox,
                categoryList[index].text.color(blackColor).align(TextAlign.center).make(),
              ],
            ).box.white.rounded.clip(Clip. antiAlias).outerShadowSm.make().onTap(() {
              controller.getSubCategories(categoryList[index]);
              Get.to(()=>CategoryDetails(title: categoryList[index]));
            });
          }),
        ),
      ),
    );
  }
}