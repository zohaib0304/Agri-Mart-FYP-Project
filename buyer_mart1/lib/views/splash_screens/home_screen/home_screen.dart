import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/consts/list.dart';
import 'package:buyer_mart1/controllers/home_controller.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/components/featured_button.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/search_screen.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/weather_screen.dart';
import 'package:buyer_mart1/widgets_common/home_buttons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
      return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                        title: controller.searchController.text,
                      )
                    );
                    }
                  }), //search bar
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchanything,
                  hintStyle: const TextStyle(color: textfieldGrey),
                ),
              ),
            ),

            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Swipers functionality of our app
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: sliderslist.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        sliderslist[index],
                        fit: BoxFit.fill,
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      3,
                      (index) => TextButton( // buttons
                        onPressed: () {
                          _navigateToScreen(context, index);
                        },
                        child: homeButtons(
                          height: context.screenHeight * 0.12,
                          width: context.screenWidth / 4.2,
                          icon: index == 0 ? icWeatherIcon : index == 1 ? icnews : icPriceIcon,
                          title: index == 0 ? weatherUpdates : index == 1 ? newsupdate : govtPrice,
                        ),
                      ),
                    ),
                  ),
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: green),
                    child: Column(
                      children: [
                        buyerschoice.text.black.fontFamily(bold).size(18).make(),
                      ],
                    ),
                  ),
                 
                  //2nd Swipers add boost
                  10.heightBox,
                  VxSwiper.builder(
                    aspectRatio: 16/9,
                    autoPlay: true,
                    height: 150,
                    enlargeCenterPage: true,
                    itemCount: secondSlidersList.length,
                    itemBuilder: (context, index) {
                      return Image.asset(
                        secondSlidersList[index],
                        fit: BoxFit.fill,
                      ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                    }
                  ),
                  // Button
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      2, (index) => TextButton(
                        onPressed: () {
                          _navigateToScreen2(context, index);
                        },
                        child: homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icgovtinst : icCropsInfo,
                          title: index == 0 ? govtinst : cropinfo,
                        )
                      )
                    ),
                  ),
                  //top agri products Category
                  20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: green),
                    child: Column(
                      children: [
                        topagriproduct.text.black.fontFamily(bold).size(18).make(),
                      ],
                    ),
                  ),
                  20.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        3, (index) => Column(
                          children: [
                            topagriProduct(icon: featuredImages1[index], title: featuredTitles1[index]).onTap(() {}),
                            10.heightBox,
                            topagriProduct(icon: featuredImages2[index], title: featuredTitles2[index]).onTap(() {}),
                          ],
                        ),
                      ).toList(),
                    ),
                  ),  

                  //Featured Product
                  
                  /*20.heightBox,
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    decoration: const BoxDecoration(color: green),
                    child: Column(
                      children: [
                        featuredProduct.text.black.fontFamily(bold).size(18).make(),
                      ],
                    ),
                  ),*/

                  // Al Products
                  
                ],
              ),
            ),
          )  
          ],
        ),      
      ),
    );
  }
}

// Function to navigate to different screens or websites based on index
void _navigateToScreen(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(context, MaterialPageRoute(builder: (context) => const WeatherScreen()));
      break;
    case 1:
      _launchUrl();
      break;
    case 2:
      _launchUrl2();
      break;
    default:
      break;
  }
}

// Function to navigate to different screens or websites based on index
void _navigateToScreen2(BuildContext context, int index) {
  switch (index) {
    case 0:
      _launchUrl3();
      break;
    case 1:
      _launchUrl4();
      break;
    default:
      break;
  }
}

// News Update Link
final Uri _url = Uri.parse('https://www.agripunjab.gov.pk/press-advertisements');
Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}

// Govt Price Link
final Uri _url2 = Uri.parse('https://lahore.punjab.gov.pk/market_rates');
Future<void> _launchUrl2() async {
  if (!await launchUrl(_url2)) {
  throw Exception('Could not launch $_url2');
  }
}

// govt Instruction Link
final Uri _url3 = Uri.parse('https://www.agripunjab.gov.pk/press-releases');
Future<void> _launchUrl3() async {
  if (!await launchUrl(_url3)) {
  throw Exception('Could not launch $_url3');
  }
}

// Crops Information Link
final Uri _url4 = Uri.parse('https://www.agripunjab.gov.pk/documentaries');
Future<void> _launchUrl4() async {
  if (!await launchUrl(_url4)) {
  throw Exception('Could not launch $_url4');
  }
}