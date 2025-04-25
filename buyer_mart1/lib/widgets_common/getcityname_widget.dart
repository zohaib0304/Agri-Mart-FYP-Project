import 'package:buyer_mart1/consts/consts.dart';

Widget getCityname(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: textfieldGrey,
                        )
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: blackColor,
                        )
                      ),
                      hintText: "Type Your City name: ",
                    ),
                  )
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.send, color: Color.fromARGB(184, 18, 248, 10))
                )
              ],
            ).box.height(75).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8.0)).make(),
          ],
        ),
      ),
    );
}