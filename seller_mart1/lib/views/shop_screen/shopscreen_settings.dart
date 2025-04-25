import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/profile_controller.dart';
import 'package:seller_mart1/views/widgets/custom_textfield.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: green,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Get.back();
            },
          ),
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isloading.value ? loadingIndicator(circleColor: white) :
            TextButton(
              onPressed: () async {
                controller.isloading(true);
                await controller.updateShop(
                  shopname: controller.shopnameController.text,
                  shopaddress: controller.shopAddressController.text,
                  shopmobile: controller.shopMobileController.text,
                  shopdesc: controller.shopDescController.text,
                  shopwebsite: controller.shopWebsiteController.text,
                );
                // ignore: use_build_context_synchronously
                VxToast.show(context, msg: "Shop Updated");
              },
              child: normalText(text: save)
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                label: shopName, hint: nameHint, controller: controller.shopnameController,
              ),
              10.heightBox,
              customTextField(
                label: address, hint: shopAddressHint, controller: controller.shopAddressController,
              ),
              10.heightBox,
              customTextField(
                label: mobile, hint: shopMobileHint, controller: controller.shopMobileController,
              ),
              10.heightBox,
              customTextField(
                label: website, hint: shopWebsiteHint, controller: controller.shopWebsiteController,
              ),
              10.heightBox,
              customTextField(
                isDesc: true,
                label: description, hint: shopDescHint, controller: controller.shopDescController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}