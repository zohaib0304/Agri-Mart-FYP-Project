import 'package:buyer_mart1/consts/consts.dart';
import 'package:buyer_mart1/controllers/home_controller.dart';
import 'package:buyer_mart1/views/category_screen/category_screen.dart';
import 'package:buyer_mart1/views/chat_screen/messaging_screen.dart';
import 'package:buyer_mart1/views/profile_screen/profile_screen.dart';
import 'package:buyer_mart1/views/splash_screens/home_screen/home_screen.dart';
import 'package:buyer_mart1/widgets_common/exit_dialog.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    //init home controller
    var controller = Get.put(HomeController());

    var navbarItem = [
      BottomNavigationBarItem(icon: Image.asset(icHomeIcon, width: 26), label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategoryicon, width: 26), label: categories),
      BottomNavigationBarItem(icon: Image.asset(icMessages, width: 26), label: message),
      BottomNavigationBarItem(icon: Image.asset(icProfileIcon, width: 26), label: account),
      
    ];
    var navBody = [
      const HomeScreen(),
      const CategoryScreen(),
      const MessagesScreen(),
      const ProfileScreen(),
    ];

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
      body: Column(
        children: [
          Obx(() => Expanded(child: navBody.elementAt(controller.currentNavIndex.value),),)
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
                currentIndex: controller.currentNavIndex.value,
                selectedItemColor: blackColor,
                selectedLabelStyle: const TextStyle(fontFamily: bold),
                type: BottomNavigationBarType.fixed,
                backgroundColor: const Color.fromARGB(184, 18, 248, 10),
                items: navbarItem,
                onTap: (value) {controller.currentNavIndex.value=value;}
              ),
      ),
    ),
    );
      
  }
}