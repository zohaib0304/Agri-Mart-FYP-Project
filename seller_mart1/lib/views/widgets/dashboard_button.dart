import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

Widget dashboardButton(context, {title,count,icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              boldText(text: title, size: 16.0),
              boldText(text: count, size: 20.0),
            ],
          ),
        ),
        Image.asset(icon, width: 40, color: white),
      ],
  ).box.color(green).rounded.size(size.width * 0.4, 80).padding(const EdgeInsets.all(8.0)).make();
}