import 'dart:math';

import 'package:ash_app/controllers/product_controller.dart';
import 'package:ash_app/model/product.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/category_layout.dart';
import 'package:ash_app/widget/custom_search_field.dart';
import 'package:ash_app/widget/productlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Categories',
            style: TextStyle(
              fontSize: 23,
              color: AppMainTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              CustomSearchField(onChanged: (val) {
                controller.searchCatProduct(val);
              }),
              Expanded(
                child: SingleChildScrollView(
                  child: controller.filterCatProducts.isNotEmpty
                      ? MasonryGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: controller.filterCatProducts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(GetRoutes.singleProductScreen,
                                    arguments: controller.filterCatProducts
                                        .toList()[index]);
                              },
                              child: ProductList(
                                product: controller.filterCatProducts
                                    .toList()[index],
                                height: Random().nextInt(150) + 150,
                              ),
                            );
                          })
                      : Column(
                          children: [
                            ...controller.categories
                                .map((e) => CategoryLayout(
                                      categoryName: e.name!,
                                      productList: controller.products
                                          .where((element) =>
                                              element.categoryId == e.id)
                                          .toList(),
                                      onSeeAllPressed: () {
                                        Get.toNamed(
                                            GetRoutes.singleCategoryScreen,
                                            arguments: e);
                                      },
                                      onProductPress: (Product product) {
                                        Get.toNamed(
                                            GetRoutes.singleProductScreen,
                                            arguments: product);
                                      },
                                    ))
                                .toList(),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
