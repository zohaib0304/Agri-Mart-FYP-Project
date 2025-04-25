import 'package:buyer_mart1/consts/consts.dart';
Widget customTextField({String? title, String? hint, controller, isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(const Color.fromARGB(255, 0, 0, 0)).fontFamily(semibold).size(18).make(),
      5.heightBox,
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
          hintStyle:const TextStyle(
            fontFamily: bold,
            color: Color.fromARGB(255, 171, 168, 168),
          ),
          hintText: hint,
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color:  Color.fromARGB(184, 18, 248, 10))),
        ),
      ),
      5.heightBox,
    ],
  );
}