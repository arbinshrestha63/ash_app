import 'package:ash_app/screens/payment.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/cart_row.dart';
import 'package:ash_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ash_app/controllers/cart_controller.dart';
import 'package:ash_app/model/cart.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Cart',
            style: TextStyle(
              fontSize: 23,
              color: AppMainTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: controller.cartList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Cart Empty',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10),
                      Text('Add items to cart to make an order'),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: controller.cartList
                              .map(
                                (CartType e) => Column(
                                  children: [
                                    CartRow(
                                      cartItem: e,
                                    ),
                                    const SizedBox(height: 10)
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Your total : ',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Rs.${controller.getTotalPriceFromCartItems()}',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 30,
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                            title: 'Order Now',
                            onPressed: () async {
                              if (!controller.isLoading) {
                                final token = await showDialog(
                                    context: (context),
                                    builder: (context) {
                                      return const KhaltiPayment();
                                    });
                                if (token == null) {
                                  return;
                                }
                                controller.makeOrder();
                              }
                            }),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
        ),
      );
    });
  }
}
