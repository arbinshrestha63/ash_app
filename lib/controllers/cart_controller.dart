import 'dart:convert';

import 'package:ash_app/controllers/bottomtab_controller.dart';
import 'package:ash_app/controllers/order_controller.dart';
import 'package:ash_app/model/cart.dart';
import 'package:ash_app/model/product.dart';
import 'package:ash_app/model/user.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:ash_app/utils/shared_prefs.dart';
import 'package:ash_app/utils/utils.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  bool isLoading = false;
  int productQuantity = 1;
  List<CartType> cartList = [];

  updateProductQuantity(int quantity) {
    productQuantity = quantity;
    update();
  }

  addToCart(Product product, int quantity) {
    //check if the item is from same restaurant
    if (cartList.isNotEmpty) {
      if (cartList[0].product.merchantId != product.merchantId) {
        customGetSnackbar(
            'Error', 'You can only order from one shop at a time!', 'error');
        return;
      }
    }

    for (var element in cartList) {
      if (element.product.id == product.id) {
        element.quantity = quantity;
        Get.back();
        customGetSnackbar('Success', 'Successfully added to cart', 'success');
        productQuantity = 1;
        update();
        return;
      }
    }

    cartList.add(CartType(product: product, quantity: quantity));
    Get.back();
    customGetSnackbar('Success', 'Successfully added to cart', 'success');
    productQuantity = 1;
    update();
  }

  updateCart(Product product, int quantity) {
    for (var element in cartList) {
      if (element.product.id == product.id) {
        element.quantity = quantity;
      }
    }
    update();
  }

  removeFromCart(Product menu) {
    cartList.removeWhere((element) => element.product.id == menu.id);
    update();
  }

  getTotalPriceFromCartItems() {
    double totalPrice = 0;
    for (var element in cartList) {
      totalPrice += int.parse(element.product.price!) * element.quantity;
    }
    return totalPrice;
  }

  makeOrder() async {
    isLoading = true;
    update();

    var orderList = cartList.map((e) {
      return {
        'id': e.product.id,
        'quantity': e.quantity,
        'line_total': int.parse(e.product.price!) * e.quantity,
      };
    }).toList();

    String merchantId = cartList[0].product.merchantId!;

    // try {
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));

    var url = Uri.parse('${baseurl}orders/addOrder.php');
    var response = await http.post(url, body: {
      'user_id': user.userId,
      'merchant_id': merchantId,
      'total_price': getTotalPriceFromCartItems().toString(),
      'orders': jsonEncode(orderList),
    });

    var res = await jsonDecode(response.body);

    if (res['success']) {
      cartList = [];
      final mainController = Get.find<BottomTabController>();
      mainController.currentIndex = 3;
      mainController.update();

      Get.toNamed(GetRoutes.orderScreen);

      final orderController = Get.find<OrderController>();
      orderController.fetchOrders();
      orderController.update();
      customGetSnackbar('Success', 'Order placed successfully', 'success');
    } else {
      customGetSnackbar('Error', 'Something went wrong here', 'error');
    }
    // } catch (e) {
    //   customGetSnackbar('Error', 'Something went wrong', 'error');
    // }

    isLoading = false;
    update();
  }
}
