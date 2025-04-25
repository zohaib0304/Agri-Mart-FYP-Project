import 'dart:io';

import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/profile_controller.dart';
import 'package:seller_mart1/views/widgets/custom_textfield.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

class EditProfilescreen extends StatefulWidget {
  final String? username;
  const EditProfilescreen({super.key, this.username});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: green,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: editProfiles, size: 16.0),
          actions: [
            controller.isloading.value ? loadingIndicator(circleColor: white): TextButton(
              onPressed: () async {
                controller.isloading(true);
                // if image not selected
                if(controller.profileImgPath.value.isNotEmpty){
                  await controller.uploadProfileImage();
                } else {
                  controller.profileImageLink = controller.snapshotData['imageUrl'];
                }
                // if old pass matches with data base
                if (controller.snapshotData['password'] == controller.oldpassController.text){
                  await controller.changeAuthPassword(
                    email: controller.snapshotData['email'],
                    password: controller.oldpassController.text,
                    newpassword: controller.newpassController.text,
                  );
                  
                  await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.newpassController.text,
                  );
                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Updated");
                } else if (controller.oldpassController.text.isEmptyOrNull && controller.newpassController.text.isEmptyOrNull){
                  await controller.updateProfile(
                    imgUrl: controller.profileImageLink,
                    name: controller.nameController.text,
                    password: controller.snapshotData['password']
                  );
                  // ignore: use_build_context_synchronously
                } else {
                  // ignore: use_build_context_synchronously
                  VxToast.show(context, msg: "Wrong Old Password");
                  controller.isloading(false);
                }
              },
              child: normalText(text: save),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // if data image url and controller path is empty
              controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty
              ? Image.asset(
                  imgProduct, width: 100, fit: BoxFit.cover
                ).box.roundedFull.clip(Clip.antiAlias).make()
                //if data is not empty but controller path is empty
              : controller.snapshotData['imageUrl'] != '' && controller.profileImgPath.isEmpty
              ? Image.network(
                controller.snapshotData['imageUrl'], width: 100, fit: BoxFit.cover
              ).box.roundedFull.clip(Clip.antiAlias).make()
                // Controller path is empty but Data Image Url is
              : Image.file(
                File(controller.profileImgPath.value),
                width: 100,
                fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make(),
              //Image.asset(imgProduct, width: 150).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(onPressed: () {
                controller.changeImage(context);
              }, child: normalText(text: changeImage, color: black)),
              const Divider(color: white),
              customTextField(label: name, hint: "eg. Zohaib Anwar", controller: controller.nameController),
              30.heightBox,
              Align(alignment: Alignment.centerLeft, child: boldText(text: "Change your Password")),
              10.heightBox,
              customTextField(label: oldpassword, hint: passwordHint, controller: controller.oldpassController),
              10.heightBox,
              customTextField(label: newPass, hint: passwordHint, controller: controller.newpassController),
          ],
          ),
        ),
      ),
    );
  }
}