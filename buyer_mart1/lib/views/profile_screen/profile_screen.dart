
import 'package:buyer_mart1/views/profile_screen/chatwithus.dart';
import 'package:buyer_mart1/views/profile_screen/helpandsupport.dart';
import 'package:buyer_mart1/views/profile_screen/settingsprofile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/consts/list.dart';
import 'package:buyer_mart1/controllers/auth_controller.dart';
import 'package:buyer_mart1/controllers/profile_controller.dart';
import 'package:buyer_mart1/services/firestore_serices.dart';
import 'package:buyer_mart1/views/chat_screen/messaging_screen.dart';
import 'package:buyer_mart1/views/profile_screen/edit_profile_screen.dart';
import 'package:buyer_mart1/views/splash_screens/auth_screen/login_screen.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:get/get.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgwidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(green),
                ),
              );
            } else {
              var data = snapshot.data!.docs[0];
              return SafeArea(
                child: Column(
                  children: [
                    // Edit Profile Button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Align(
                        alignment: Alignment.topCenter, child: Icon(Icons.edit, color: blackColor)).onTap(() {
                        controller.nameController.text = data['name'];
                        Get.to(() => EditProfileScreen(data: data));
                      }),
                    ),
                    //user details section
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        data['imageurl'] == ''
                        ? Image.asset(imgProfile2, width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(data['imageurl'], width: 100, fit: BoxFit.cover).box.roundedFull.clip(Clip.antiAlias).make(),
                        
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.fontFamily(semibold).black.make(),
                              5.heightBox,
                              "${data['email']}".text.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: blackColor,
                            )
                          ),
                          onPressed: () async {
                            await Get.put(AuthController()).signoutMethod(context);
                            Get.offAll(() => const LoginScreen());
                          },
                          child: logout.text.fontFamily(semibold).black.make(),
                        ),
                      ],
                    ),
                    ),

                    // Buttons Section
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(color: lightGrey);
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(()=>const MessagesScreen());
                                break;
                              case 1:
                                Get.to(()=> HelpandSupport());
                                break;
                              case 2:
                                Get.to(()=> ChatwithUs());
                                break;
                              case 3:
                                Get.to(()=> SettingsProfile());
                                break;
                            }
                          },
                          leading: Image.asset(profileButtonsIcon[index],
                          width: 22
                          ),
                          title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                        );
                      },
                    ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(green).make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}