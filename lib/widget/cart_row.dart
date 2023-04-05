import 'package:ash_app/controllers/cart_controller.dart';
import 'package:ash_app/model/cart.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/cart_btn.dart';
import 'package:ash_app/widget/image_label.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartRow extends StatelessWidget {
  const CartRow({Key? key, required this.cartItem}) : super(key: key);

  final CartType cartItem;

  showAlertDialog(context, controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove item'),
        content:
            const Text('Are you sure you want to remove this item from cart?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
              onPressed: () {
                controller.removeFromCart(cartItem.product);
                Navigator.pop(context);
              },
              child: const Text('Yes')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImageLabel(
            image: baseurl + cartItem.product.image!,
            title: cartItem.product.name!,
            subTitle: 'Rs. ${cartItem.product.price}',
          ),
          Row(
            children: [
              CartBtn(
                onTap: () {
                  if (cartItem.quantity > 1) {
                    controller.updateCart(
                        cartItem.product, cartItem.quantity - 1);
                  } else {
                    showAlertDialog(context, controller);
                  }
                },
                color: const Color(0xffff0000),
                label: '-',
                textColor: Colors.white,
                labelSize: 18,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                cartItem.quantity.toString(),
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 30,
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CartBtn(
                onTap: () {
                  controller.updateCart(
                      cartItem.product, cartItem.quantity + 1);
                },
                color: AppMainTheme.primaryColor,
                label: '+',
                textColor: Colors.white,
                labelSize: 18,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              )
            ],
          )
        ],
      );
    });
  }
}
