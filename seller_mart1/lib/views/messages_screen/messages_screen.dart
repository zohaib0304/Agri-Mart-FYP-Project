import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/services/store_services.dart';
import 'package:seller_mart1/views/chat_screen/chat_screen.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: green,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: messages, size: 16.0, color: green),
      ),
      body: StreamBuilder(
        stream: StoreServices.getMessages(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(
                    data.length, (index) {
                      var t = data[index]['created_on'] == null ? DateTime.now() : data[index]['created_on'].toDate();
                      var time = intl.DateFormat("h:mma").format(t);
                      return ListTile(
                        onTap: () {
                          Get.to(() => const ChatScreen());
                        },
                        leading: const CircleAvatar(
                          backgroundColor: green,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                        title: boldText(text: "${data[index]['sender_name']}", color: green),
                        subtitle: normalText(text: "${data[index]['last_msg']}", color: green),
                        trailing: normalText(text: time, color: green),
                      );
                    }
                  ),
                ),
              ),
            );
          }
        }
      )
    );
  }
}