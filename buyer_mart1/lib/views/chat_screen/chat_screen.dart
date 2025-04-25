import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/controllers/chats_controllers.dart';
import 'package:buyer_mart1/services/firestore_serices.dart';
import 'package:buyer_mart1/views/chat_screen/components/sender_bubble.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:buyer_mart1/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return bgwidget(
      child: Scaffold(
        appBar: AppBar(
          title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Obx(
                () => 
                controller.isLoading.value ? Center(
                  child: loadingIndicator(),
                )
                : Expanded(
                  child: StreamBuilder(
                    stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: loadingIndicator(),
                        );
                      } else if(snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: "Send a message...".text.color(blackColor).make(),
                        );
                      } else {
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                            var data = snapshot.data!.docs[index];
                              return Align(
                                alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                                child: senderBubble(data),
                              );
                            }
                          ).toList(),
                        );
                      }
                    }
                  )
                ),
              ),
              10.heightBox,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.msgController,
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
                          hintText: "Text a Message...",
                        ),
                      )
                    ),
                    IconButton(
                      onPressed: () {
                        controller.sendMsg(controller.msgController.text);
                        controller.msgController.clear();
                      },
                      icon: const Icon(Icons.send, color: Color.fromARGB(184, 18, 248, 10))
                    )
                  ],
                ).box.height(75).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 8.0)).make(),
              ],
            ),
          ),
        ),
      );
    }
}