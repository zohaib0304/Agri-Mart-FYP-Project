
import 'package:get/get.dart';
import 'package:seller_mart1/const/const.dart';
import 'package:seller_mart1/controllers/products_controller.dart';
import 'package:seller_mart1/views/products_screen/components/product_dropdown.dart';
import 'package:seller_mart1/views/products_screen/components/product_images.dart';
import 'package:seller_mart1/views/widgets/custom_textfield.dart';
import 'package:seller_mart1/views/widgets/loading_indicator.dart';
import 'package:seller_mart1/views/widgets/text_style.dart';


class AddProduct extends StatelessWidget {
  // ignore: use_super_parameters
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.green,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: Colors.white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImages();
                      // ignore: use_build_context_synchronously
                      await controller.uploadProduct(context);
                      controller.isloading(false);
                      Get.back();
                    },
                    child: boldText(text: "Save", color: Colors.white),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                  hint: "eg. Mango",
                  label: "Product Name",
                  controller: controller.pnameController,
                ),
                const SizedBox(height: 10),
                customTextField(
                  hint: "Product Description",
                  label: "Description",
                  isDesc: true,
                  controller: controller.pdescController,
                ),
                const SizedBox(height: 10),
                customTextField(
                  hint: "eg. \$100",
                  label: "Price",
                  controller: controller.ppriceController,
                ),
                const SizedBox(height: 10),
                customTextField(
                  hint: "eg. 100 KG",
                  label: "Quantity",
                  controller: controller.pquantityController,
                ),
                const SizedBox(height: 10),
                productDropdown(
                  "Category",
                  controller.categoryList.map((category) => category.name).toList(),
                  controller.categoryvalue,
                  controller,
                ),
                const SizedBox(height: 10),
                productDropdown(
                  "Subcategory",
                  controller.subcategoryList,
                  controller.subcategoryvalue,
                  controller,
                ),
                const Divider(color: Colors.white),
                const SizedBox(height: 10),
                boldText(
                  text: "Choose Product Images...",
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                    3,
                    (index) => controller.pImagesList[index] != null
                        ? Image.file(
                            controller.pImagesList[index]!,
                            width: 100,
                            height: 100,
                          ).onTap(() {
                            controller.pickImage(index, context);
                          })
                        : productImages(
                            label: "${index + 1}",
                          ).onTap(() {
                            controller.pickImage(index, context);
                          }),
                  ),
                ),
                const SizedBox(height: 5),
                normalText(
                  text: "First Image will be your display image",
                  color: darkGrey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
