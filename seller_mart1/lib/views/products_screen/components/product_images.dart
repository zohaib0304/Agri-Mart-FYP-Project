
import 'package:seller_mart1/const/const.dart';

Widget productImages ({required label, onPress}) {
  return "$label".text.bold.color(black).size(16.0).makeCentered().box.color(white).size(100, 100).roundedSM.make();
}