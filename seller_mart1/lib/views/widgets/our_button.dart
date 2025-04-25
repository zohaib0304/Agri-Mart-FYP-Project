
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

Widget ourButton({title, color = green, onPress, required Future<Null> Function() onPressed}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      backgroundColor: green,
      padding: const EdgeInsets.all(12.0),
    ),
    onPressed: onPressed,
    child: boldText(
      text: title, size: 16.0
    ),
  );
}