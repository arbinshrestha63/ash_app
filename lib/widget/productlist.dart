import 'package:ash_app/model/product.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:flutter/material.dart';

class ProductList extends StatelessWidget {
  const ProductList(
      {super.key,
      this.height = 150,
      this.marginRight = 10,
      this.marginBottom = 0,
      this.fromNear = false,
      required this.product});

  final double height;
  final double marginRight;
  final double marginBottom;

  final bool? fromNear;

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: marginRight, bottom: marginBottom),
      child: Stack(
        children: [
          Container(
              height: height,
              width: MediaQuery.of(context).size.width * 0.42,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      baseurl + product.image!,
                      // 'https://images.pexels.com/photos/47730/the-ball-stadion-football-the-pitch-47730.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ))),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: height,
              width: MediaQuery.of(context).size.width * 0.42,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0x70000000),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x29000000),
                    offset: Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Rs. ${product.price}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xffffffff),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
