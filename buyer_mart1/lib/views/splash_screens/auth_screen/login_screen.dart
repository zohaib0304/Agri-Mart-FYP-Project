import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/controllers/auth_controller.dart';
import 'package:buyer_mart1/views/splash_screens/auth_screen/signup_screen.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/home.dart';
import 'package:buyer_mart1/widgets_common/applogo_widget.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:buyer_mart1/widgets_common/custom_textfield.dart';
import 'package:buyer_mart1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());
    return bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              15.heightBox,
              "Log in to $appname".text.fontFamily(bold).black.size(18).make(),
              10.heightBox,

              Obx(
                () => Column(
                  children: [
                    customTextField(hint: emailHint, title: email, isPass: false, controller: controller.emailController),
                    customTextField(hint: passwordHint, title: password, isPass: true, controller: controller.passwordController),
                    /*Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetpass.text.make())
                    ),*/
                    20.heightBox,
                    //ourButton().box.width(context.screenWidth - 50).make(),
                    controller.isloading.value? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(green),
                    )
                    :ourButton(color: green,title: login, textColor: blackColor, onPress: () async {
                      controller.isloading(true);
                      await controller.loginMethod(context: context).then((value) {
                        if (value != null) {
                          VxToast.show(context, msg: loggedin);
                          Get.offAll(() => const Home());
                        } else{
                          controller.isloading(false);
                        }
                      });
                      //Get.to(() => const Home());
                    }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    createnewaccount.text.color(darkFontGrey).make(),
                    5.heightBox,
                    ourButton(color: green, title: signup, textColor: blackColor, onPress: (){
                      Get.to(() => const SignupScreen());
                    }).box
                    .width(context.screenWidth - 50)
                    .make(),
                    10.heightBox,
                    
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -40).shadowSm.make()
          )],
          ),
        ),
      ));
  }
}