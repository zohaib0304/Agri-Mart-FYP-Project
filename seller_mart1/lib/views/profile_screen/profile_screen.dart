import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/auth_controller.dart';
import 'package:seller_mart1/controllers/profile_controller.dart';
import 'package:seller_mart1/services/store_services.dart';
import 'package:seller_mart1/views/auth_screen/login_screen.dart';
import 'package:seller_mart1/views/messages_screen/messages_screen.dart';
import 'package:seller_mart1/views/profile_screen/edit_profilescreen.dart';
import 'package:seller_mart1/views/shop_screen/shopscreen_settings.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: green,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(onPressed: () {
            Get.to(() => EditProfilescreen(
              username: controller.snapshotData['vendor_name'],
            ));
          }, icon: const Icon(Icons.edit, color: white)),
          TextButton(
            onPressed: () async {
              await Get.find<AuthController>().signoutMethod(context);
              Get.offAll(() => const LoginScreen());

              //Get.to(() => const LoginScreen());
            },
            child: normalText(text: logout)
          ),
        ],
      ),
      body: FutureBuilder(
        future: StoreServices.getProfile(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circleColor: white);
          } else {
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(
              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(imgProduct, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(controller.snapshotData['imageUrl'], width: 100).box.roundedFull.clip(Clip.antiAlias).make(),
                  //Image.asset(imgProduct).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: "${controller.snapshotData['vendor_name']}"),
                  subtitle: normalText(text: "${controller.snapshotData['email']}"),
                ),
                const Divider(),
                10.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: List.generate(profileButtonIcons.length,
                    (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.to(() => const ShopSettings());
                            break;
                          case 1:
                            Get.to(() => const MessagesScreen());
                          default:
                        }
                      } ,
                      leading: Icon(profileButtonIcons[index], color: white),
                      title: normalText(text: profileButtonTitles[index], color: white),
                    )),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}