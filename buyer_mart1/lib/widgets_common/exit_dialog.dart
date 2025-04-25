import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/widgets_common/our_button.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(color: green, onPress: () {
              SystemNavigator.pop();
            }, textColor: blackColor, title: "Yes"),
            ourButton(color: green, onPress: () {
              navigator!.pop(context);
            }, textColor: blackColor, title: "No"),
          ],
        ),
      ]
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}