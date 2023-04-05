import 'package:ash_app/controllers/cart_controller.dart';
import 'package:ash_app/model/product.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/cart_btn.dart';
import 'package:ash_app/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SingleProudctScreen extends StatelessWidget {
  SingleProudctScreen({
    Key? key,
  }) : super(key: key);

  final Product product = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Stack(
          children: [
            Image(
              image: NetworkImage(baseurl + product.image!),
              // image: const NetworkImage(
              //   'https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg',
              // ),
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 40,
              left: 20,
              child: Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0x50000000),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.name!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          color: Color(0xff000000),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Text(
                      'Rs. ${product.price}',
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${product.merchantName}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppMainTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      product.description!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xff000000),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                GetBuilder<CartController>(builder: (controller) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CartBtn(
                            onTap: () {
                              if (controller.productQuantity > 1) {
                                controller.updateProductQuantity(
                                    controller.productQuantity - 1);
                              }
                            },
                            color: const Color(0xffff0000),
                            label: '-',
                            labelSize: 15,
                            textColor: Colors.white,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Text(
                            controller.productQuantity.toString(),
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 50,
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                            ),
                            softWrap: false,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          CartBtn(
                            onTap: () {
                              controller.updateProductQuantity(
                                  controller.productQuantity + 1);
                            },
                            color: Colors.green,
                            label: '+',
                            labelSize: 15,
                            textColor: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                          onPressed: () {
                            controller.addToCart(
                                product, controller.productQuantity);
                          },
                          title: 'Add To Cart'),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  );
                })
              ],
            ),
          ),
        )
      ],
    ));
  }
}
