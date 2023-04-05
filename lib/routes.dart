import 'package:ash_app/screens/home/entry_screen.dart';
import 'package:ash_app/screens/home/single_category_screen.dart';
import 'package:ash_app/screens/home/single_product_screen.dart';
import 'package:ash_app/screens/orders/orders_screen.dart';
import 'package:get/get.dart';
import 'package:ash_app/screens/auth/login_screen.dart';
import 'package:ash_app/screens/auth/signup_screen.dart';
import 'package:ash_app/screens/auth/splash_screen.dart';

class GetRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String entry = '/entry';
  static const String singleCategoryScreen = '/single-category-screen';
  static const String singleProductScreen = '/single-product-screen';
  static const String orderScreen = '/order-screen';

  static List<GetPage> routes = [
    GetPage(name: GetRoutes.splash, page: () => SplashScreen()),
    GetPage(name: GetRoutes.login, page: () => LoginScreen()),
    GetPage(name: GetRoutes.signup, page: () => SignupScreen()),
    GetPage(name: GetRoutes.entry, page: () => EntryScreen()),
    GetPage(
        name: GetRoutes.singleCategoryScreen,
        page: () => SingleCategoryScreen()),
    GetPage(
        name: GetRoutes.singleProductScreen, page: () => SingleProudctScreen()),
    GetPage(
      name: GetRoutes.orderScreen,
      page: () => const OrdersScreen(),
    ),
  ];
}
