import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/chats_controller.dart';
import 'package:seller_mart1/services/store_services.dart';
import 'package:seller_mart1/views/messages_screen/components/chat_bubble.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: green),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "${controller.friendName}", size: 16.0, color: green),
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
                  stream: StoreServices.getChatMessages(controller.chatDocId.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: loadingIndicator(),
                        );
                    } else if(snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: "Send a message...".text.color(black).make(),
                        );
                    } else {
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                            return Align(
                              alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                              child: chatBubble(data),
                            );
                          }
                        ).toList(),
                      );
                    }
                  }
                ),
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.msgController,
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter message..",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: green
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: green
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.sendMsg(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(Icons.send, color: green),
                ),
              ],
            ).box.padding(const EdgeInsets.all(8)).make(),
          ],
        ),
      ),
    );
  }
}

/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyer_agri_mart/consts/consts.dart';
import 'package:buyer_agri_mart/controllers/chats_controllers.dart';
import 'package:buyer_agri_mart/services/firestore_serices.dart';
import 'package:buyer_agri_mart/views/chat_screen/components/sender_bubble.dart';
import 'package:buyer_agri_mart/widgets_common/bgwidget.dart';
import 'package:buyer_agri_mart/widgets_common/loading_indicator.dart';
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
} */