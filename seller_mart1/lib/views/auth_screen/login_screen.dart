import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/auth_controller.dart';
import 'package:seller_mart1/views/home_screen/home.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/our_button.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 3, 107, 45),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(icLogo, width: 70, height: 70).box.border(color: white).rounded.padding(const EdgeInsets.all(8.0)).make(),
                  10.widthBox,
                  boldText(text: appname, size: 22.0),
                ],
              ),
              60.heightBox,
              normalText(text: loginto, size: 18.0, color: lightGrey),
              10.heightBox,
              Column(
                children: [
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 3, 107, 45)),
                      border: InputBorder.none,
                      hintText: emailHint,
                    ),
                  ),
                  10.heightBox,
                  TextFormField(
                    obscureText: true,
                    controller: controller.passwordController,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: lightGrey,
                      prefixIcon: Icon(Icons.lock, color: Color.fromARGB(255, 3, 107, 45)),
                      border: InputBorder.none,
                      hintText: passwordHint,
                    ),
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: normalText(text: forgotPassword, color: green),
                    ),
                  ),
                  20.heightBox,
                  SizedBox(
                    width: context.screenWidth - 250,
                    child: Obx(
                      () => controller.isloading.value? loadingIndicator() : ourButton(
                        title: 'Login',
                        onPressed: () async {
                          controller.isloading(true);
                          await controller.loginMethod(context: context).then((value) {
                            if (value != null) {
                              VxToast.show(context, msg: "Logged in");
                              controller.isloading(false);
                              Get.offAll(() => const Home());
                            } else {
                              controller.isloading(false);
                            }
                          }
                        );
                      },
                    ),
                    ),
                  ),
                ],
              ).box.white.rounded.outerShadowMd.padding(const EdgeInsets.all(8.0)).make(),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: lightGrey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}