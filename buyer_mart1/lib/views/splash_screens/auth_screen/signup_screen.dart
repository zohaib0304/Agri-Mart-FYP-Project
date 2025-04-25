import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/controllers/auth_controller.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/home.dart';
import 'package:buyer_mart1/widgets_common/applogo_widget.dart';
import 'package:buyer_mart1/widgets_common/bgwidget.dart';
import 'package:buyer_mart1/widgets_common/custom_textfield.dart';
import 'package:buyer_mart1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  // text controller
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgwidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              20.heightBox,
              "Join the $appname".text.fontFamily(bold).black.size(18).make(),
              10.heightBox,

              Obx(
                () => Column(
                  children: [
                    customTextField(hint: nameHint, title: name, controller: nameController, isPass: false),
                    customTextField(hint: emailHint, title: email, controller: emailController, isPass: false),
                    customTextField(hint: passwordHint, title: password, controller: passwordController, isPass: true),
                    customTextField(hint: passwordHint, title: retypePassword, controller: passwordRetypeController, isPass: true),
                    /*Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(onPressed: (){}, child: forgetpass.text.make())

                    ),*/
                    20.heightBox,
                    //ourButton().box.width(context.screenWidth - 50).make(),
                  
                    Row(
                      children: [
                        Checkbox(
                          checkColor: green,
                          value: isCheck, onChanged: (newvalue) {
                            setState(() {
                              isCheck = newvalue;
                            });
                          },
                        ),
                        10.widthBox,
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the",
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: darkFontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: termscond,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "&",
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: darkFontGrey,
                                  ),
                                ),
                                TextSpan(
                                  text: privacypolicy,
                                  style: TextStyle(
                                    fontFamily: bold,
                                    color: redColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.isloading.value? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(green),
                    ):ourButton(color: isCheck == true? green : lightGrey, title: signup, textColor: blackColor, onPress: () async {
                      if(isCheck != false){
                        controller.isloading(true);
                        try {
                          await controller.signupMethod(context: context, email: emailController.text, password: passwordController.text).then((value){
                            return controller.storeUserData(email: emailController.text, password: passwordController.text, name: nameController.text);
                          }).then((value){
                            VxToast.show(context, msg: loggedin);
                            Get.offAll(() => const Home());
                          });
                        } catch (e) {
                          auth.signOut();
                          // ignore: use_build_context_synchronously
                          VxToast.show(context, msg: e.toString());
                          controller.isloading(false);
                        }
                      }
                    }).box
                    .width(context.screenWidth - 50)
                    .make(),
                    10.heightBox,
                    //wrapping into gesture detector of velocity x
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        alreadyhavenacc.text.color(darkFontGrey).make(),
                        login.text.color(green).make().onTap(() {
                          Get.back();
                        }),
                      ],
                    )
                  ],
                ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth -40).shadowSm.make()
          )],
          ),
        ),
      ));
  }
}