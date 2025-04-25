
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
        automaticallyImplyLeading: false,
        title: boldText(text: title, color: green, size: 16.0),
        actions: [
          Center(
            child: boldText(text: intl.DateFormat('EEE, MMM d, ' 'yyyy').format(DateTime.now()), color: green),
          ),
          10.widthBox,
        ],
      );
}