import 'package:ash_app/screens/home/categories_screen.dart';
import 'package:get/get.dart';
import 'package:ash_app/screens/home/account_screen.dart';
import 'package:ash_app/screens/home/cart_screen.dart';
import 'package:ash_app/screens/home/home_screen.dart';

class BottomTabController extends GetxController {
  int currentIndex = 0;
  final List children = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const AccountScreen()
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
