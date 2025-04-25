import 'dart:io';

import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/controllers/profile_controller.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:buyer_mart1/widgets_common/custom_textfield.dart';
import 'package:buyer_mart1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {

  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<ProfileController>();
    return bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(() => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Displaying the profile image
            _buildProfileImage(controller),
            const SizedBox(height: 10),
            // Button to change the profile image
            _buildChangeImageButton(controller, context),
            const Divider(),
            const SizedBox(height: 20),
            // Text field for name
            _buildNameTextField(controller),
            const SizedBox(height: 10),
            // Text field for old password
            _buildOldPasswordTextField(controller),
            const SizedBox(height: 10),
            // Text field for new password
            _buildNewPasswordTextField(controller),
            const SizedBox(height: 20),
            // Button to save changes
            _buildSaveButton(controller, context),
          ],
        ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12)).rounded.make()
        ),
      ),
    );
  }

  Widget _buildProfileImage(ProfileController controller) {
    if (data['imageurl'] == '' && controller.profileImgPath.isEmpty) {
      return Image.asset(
        imgProfile2, 
        width: 100, 
        fit: BoxFit.cover,
      ).box.roundedFull.clip(Clip.antiAlias).make();
    } else if (data['imageurl'] != '' && controller.profileImgPath.isEmpty) {
      return Image.network(
        data['imageurl'], 
        width: 100, 
        fit: BoxFit.cover,
      ).box.roundedFull.clip(Clip.antiAlias).make();
    } else {
      return Image.file(
        File(controller.profileImgPath.value),
        width: 100,
        fit: BoxFit.cover,
      ).box.roundedFull.clip(Clip.antiAlias).make();
    }
  }

  Widget _buildChangeImageButton(ProfileController controller, BuildContext context) {
    return ourButton(
      color: green, 
      onPress: () {
        controller.changeImage(context);
      },
      textColor: blackColor, 
      title: "Change"
    );
  }

  Widget _buildNameTextField(ProfileController controller) {
    return customTextField(
      controller: controller.nameController,
      hint: nameHint,
      title: name,
      isPass: false,
    );
  }

  Widget _buildOldPasswordTextField(ProfileController controller) {
    return customTextField(
      controller: controller.oldpassController,
      hint: passwordHint,
      title: oldpass,
      isPass: true,
    );
  }

  Widget _buildNewPasswordTextField(ProfileController controller) {
    return customTextField(
      controller: controller.newpassController,
      hint: passwordHint,
      title: newpass,
      isPass: true,
    );
  }

  Widget _buildSaveButton(ProfileController controller, BuildContext context) {
    return controller.isloading.value
      ? const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(green),
        )
      : SizedBox(
          width: context.screenWidth - 60,
          child: ourButton(
            color: green, 
            onPress: () async {
              controller.isloading(true);

              if(controller.profileImgPath.value.isNotEmpty){
                await controller.uploadProfileImage();
              } else {
                controller.profileImageLink = data['imageurl'];
              }

              if (data['password'] == controller.oldpassController.text){
                await controller.changeAuthPassword(
                  email: data['email'],
                  password: controller.oldpassController.text,
                  newpassword: controller.newpassController.text,
                );

                await controller.updateProfile(
                  imgurl: controller.profileImageLink,
                  name: controller.nameController.text,
                  //password: controller.newpassController.text,
                );

                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Updated");
              } else {
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Wrong Old Password");
                controller.isloading(false);
              }
            },
            textColor: blackColor, 
            title: "Save",
          ),
        );
  }
}

// class EditProfileScreen extends StatelessWidget {

//   final dynamic data;
//   const EditProfileScreen({super.key, this.data});

//   @override
//   Widget build(BuildContext context) {

//     var controller = Get.find<ProfileController>();
//     ProfileController pc = new ProfileController();
//     return bgwidget(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(),
//         body: Obx(() => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // if data image url and controller path is empty
//             data['imageurl'] == '' && controller.profileImgPath.isEmpty
//             ? Image.asset(
//                 imgProfile2, width: 100, fit: BoxFit.cover
//               ).box.roundedFull.clip(Clip.antiAlias).make()
//               //if data is not empty but controller path is empty
//             : data['imageurl'] != '' && controller.profileImgPath.isEmpty
//               ? Image.network(
//                   data['imageurl'], width: 100, fit: BoxFit.cover
//                 ).box.roundedFull.clip(Clip.antiAlias).make()
//                 // Controller path is empty but Data Image Url is
//                 : Image.file(
//                     File(controller.profileImgPath.value),
//                     width: 100,
//                     fit: BoxFit.cover,
//                   ).box.roundedFull.clip(Clip.antiAlias).make(),
//           10.heightBox,
//           ourButton(color: green, onPress: (){
//             controller.changeImage(context);
//           },textColor: blackColor, title: "Change"),
//           const Divider(),
//           20.heightBox,
//           customTextField(
//             controller: controller.nameController,
//             hint: nameHint,
//             title: name,
//             isPass: false
//           ),
//           10.heightBox,
//           customTextField(
//             controller: controller.oldpassController,
//             hint: passwordHint,
//             title: oldpass,
//             isPass: true
//           ),
//           10.heightBox,
//           customTextField(
//             controller: controller.newpassController,
//             hint: passwordHint,
//             title: newpass,
//             isPass: true
//           ),
//           20.heightBox,
//           controller.isloading.value
//           ? const CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation(green),
//           )
//           : SizedBox(
//             width: context.screenWidth - 60,
//              child: ourButton(color: green, onPress: () async{
              

//               controller.isloading(true);
//               // if image not selected
//               if(controller.profileImgPath.value.isNotEmpty){
//                 await controller.uploadProfileImage();
//               } else {
//                 controller.profileImageLink = data['imageurl'];
//               }
//               // of old pass matches with data base
//               if (data[password] == controller.oldpassController.text){
//                 await pc.changeAuthPassword(
//                   email: data['email'],
//                   password: controller.oldpassController.text,
//                   newpassword: controller.newpassController.text,
//                 );
                
//                 await pc.updateProfile(
//                   imgurl: controller.profileImageLink,
//                   name: controller.nameController.text,
//                   password: controller.newpassController.text,
//                 );
//                 // ignore: use_build_context_synchronously
//                 VxToast.show(context, msg: "Updated");
//               } else {
//                 // ignore: use_build_context_synchronously
//                 VxToast.show(context, msg: "Wrong Old Password");
//                 controller.isloading(false);
//               }

              
              
//              },textColor: blackColor, title: "Save"),
//           )
//         ],
//       ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12)).rounded.make()
//       ),
//       ),
//       );
//   }
// }