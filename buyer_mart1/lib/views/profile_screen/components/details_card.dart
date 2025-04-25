import 'package:buyer_mart1/consts/consts.dart';
Widget detailsCard(width, String? count, String? title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(blackColor).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).make(),
    ],
  ).box.green100.rounded.width(width).height(80).padding(const EdgeInsets.all(4)).make();
}