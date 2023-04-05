import 'dart:math';

import 'package:ash_app/controllers/product_controller.dart';
import 'package:ash_app/model/category.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/productlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class SingleCategoryScreen extends StatelessWidget {
  SingleCategoryScreen({Key? key}) : super(key: key);

  final Category category = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: AppMainTheme.primaryColor),
            title: Text(
              category.name!,
              style: const TextStyle(
                fontSize: 23,
                color: AppMainTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MasonryGridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: controller.products
                          .where((element) => element.categoryId == category.id)
                          .toList()
                          .length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(GetRoutes.singleProductScreen,
                                arguments: controller.products
                                    .where((element) =>
                                        element.categoryId == category.id)
                                    .toList()[index]);
                          },
                          child: ProductList(
                            product: controller.products
                                .where((element) =>
                                    element.categoryId == category.id)
                                .toList()[index],
                            height: Random().nextInt(150) + 150,
                          ),
                        );
                      })
                ],
              ),
            ),
          ));
    });
  }
}
