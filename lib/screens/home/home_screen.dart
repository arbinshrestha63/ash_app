import 'dart:math';

import 'package:ash_app/controllers/product_controller.dart';
import 'package:ash_app/model/product.dart';
import 'package:ash_app/routes.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/category_layout.dart';
import 'package:ash_app/widget/custom_search_field.dart';
import 'package:ash_app/widget/productlist.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
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
                controller.search(val);
              }),
              Expanded(
                child: SingleChildScrollView(
                  child: controller.filterProducts.isNotEmpty
                      ? MasonryGridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          itemCount: controller.filterProducts.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.toNamed(GetRoutes.singleProductScreen,
                                    arguments: controller.filterProducts
                                        .toList()[index]);
                              },
                              child: ProductList(
                                product:
                                    controller.filterProducts.toList()[index],
                                height: Random().nextInt(150) + 150,
                              ),
                            );
                          })
                      : Column(
                          children: [
                            HomeCarousel(
                                latestProducts:
                                    controller.products.take(4).toList()),
                            const SizedBox(
                              height: 20,
                            ),
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

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({Key? key, required this.latestProducts})
      : super(key: key);

  final List<Product> latestProducts;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(viewportFraction: 1, aspectRatio: 19 / 9),
      items: latestProducts.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return InkWell(
              onTap: () {
                Get.toNamed(GetRoutes.singleProductScreen, arguments: i);
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Stack(
                      children: [
                        Image(
                          height: 172,
                          width: MediaQuery.of(context).size.width,
                          image: NetworkImage(baseurl + i.image!),
                          fit: BoxFit.cover,
                          alignment: Alignment.topRight,
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          height: 172,
                          width: MediaQuery.of(context).size.width,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            color: Colors.black.withOpacity(0.6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  i.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  i.date!,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  i.description!.length < 40
                                      ? i.description!
                                      : '${i.description!.substring(0, 40)} . . .',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xffffffff),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
