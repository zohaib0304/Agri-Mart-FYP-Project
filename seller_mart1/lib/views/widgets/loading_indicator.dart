import 'package:seller_mart1/const/const.dart';

Widget loadingIndicator({circleColor = green}) {
  return CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(circleColor),
  );
}