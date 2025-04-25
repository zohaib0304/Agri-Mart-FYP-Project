import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/views/category_screen/category_details.dart';
import 'package:get/get.dart';
Widget topagriProduct({String? title, icon}) {
  return Row(
    children: [
      Image.asset(icon, width: 60,fit: BoxFit.fill),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  ).box.width(200).margin(
    const EdgeInsets.symmetric(horizontal: 4)
  ).white.padding(const EdgeInsets.all(7)).roundedSM.outerShadowSm.make().onTap(() {Get.to(() => CategoryDetails(title: title));});
}