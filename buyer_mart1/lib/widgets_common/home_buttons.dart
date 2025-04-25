import 'package:buyer_mart1/consts/consts.dart';
Widget homeButtons({width, height, icon, String? title, onPress}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(icon, width: 40),
      10.heightBox, title!.text.fontFamily(bold).center.color(darkFontGrey).make()
    ],
  ).box.rounded.white.size(width, height).shadowSm.make();
  //.onTap(() {
   // Image.asset(urlimage);
  //}
}