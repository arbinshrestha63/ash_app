import 'package:ash_app/controllers/bottomtab_controller.dart';
import 'package:ash_app/controllers/cart_controller.dart';
import 'package:ash_app/controllers/order_controller.dart';
import 'package:ash_app/controllers/product_controller.dart';
import 'package:ash_app/controllers/user_controller.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/icon_with_badge.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class EntryScreen extends StatelessWidget {
  EntryScreen({Key? key}) : super(key: key);

  final userController = Get.put(UserController());
  // final orderController = Get.put(OrderController());
  final bottomTabController = Get.put(BottomTabController());
  final cartController = Get.put(CartController());
  final productController = Get.put(ProductController());
  final orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabController>(builder: (controller) {
      return Scaffold(
        body: controller.children[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.onTabTapped,
          currentIndex: controller.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppMainTheme.primaryColor,
          selectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          items: [
            const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 20,
              ),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: IconWithBadge(
                icon: FaIcon(
                  FontAwesomeIcons.dashcube,
                  size: 20,
                ),
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: GetBuilder<CartController>(builder: (controller) {
                return IconWithBadge(
                  label: controller.cartList.length,
                  icon: const FaIcon(
                    FontAwesomeIcons.shoppingCart,
                    size: 20,
                  ),
                );
              }),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: IconWithBadge(
                icon: FaIcon(
                  FontAwesomeIcons.user,
                  size: 20,
                ),
              ),
              label: 'Account',
            ),
          ],
        ),
      );
    });
  }
}
