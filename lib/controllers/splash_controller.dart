import 'package:get/get.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/shared_prefs.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), checkUserLogin);
  }

  checkUserLogin() async {
    var usr = await SharedPrefs().getUser();
    if (usr != null) {
      Get.offAllNamed(GetRoutes.entry);
    } else {
      Get.offAllNamed(GetRoutes.login);
    }
  }
}
