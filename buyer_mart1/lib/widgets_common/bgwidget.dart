import 'package:buyer_mart1/consts/consts.dart';
Widget bgwidget({Widget? child}) {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill)
     ),
     child: child,
  );
}