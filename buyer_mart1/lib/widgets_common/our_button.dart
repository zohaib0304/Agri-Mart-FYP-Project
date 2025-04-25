import 'package:buyer_mart1/consts/consts.dart';
Widget ourButton({onPress, color, textColor, String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      //primary: color,
      backgroundColor: green,
      padding: const EdgeInsets.all(12),
    ),
    onPressed: onPress,
    child: title! .text.color(textColor).fontFamily(bold).make(),
  );
}