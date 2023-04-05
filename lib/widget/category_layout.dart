import 'package:ash_app/model/product.dart';
import 'package:ash_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:ash_app/widget/productlist.dart';

class CategoryLayout extends StatelessWidget {
  const CategoryLayout({
    super.key,
    this.categoryName = '',
    this.productList = const [],
    this.onSeeAllPressed,
    this.onProductPress,
  });

  final String categoryName;
  final List<Product> productList;
  final Function? onSeeAllPressed;
  final Function(Product product)? onProductPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              categoryName,
              style: const TextStyle(
                fontSize: 20,
                color: AppMainTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () {
                onSeeAllPressed!();
              },
              child: const Text(
                'See All',
                style: TextStyle(
                  fontSize: 14,
                  color: AppMainTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: productList
                .map((e) => InkWell(
                    onTap: () {
                      onProductPress!(e);
                    },
                    child: ProductList(
                      product: e,
                    )))
                .toList(),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
