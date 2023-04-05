import 'package:ash_app/model/orders.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:ash_app/widget/image_label.dart';
import 'package:flutter/material.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({Key? key, required this.orderLines}) : super(key: key);

  final OrderLines orderLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ImageLabel(
            image: '$baseurl${orderLines.image}',
            title: orderLines.name!,
            subTitle: 'Rs. ${orderLines.price!}',
          ),
          const SizedBox(width: 20),
          Text(
            'x${orderLines.quantity}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
            softWrap: false,
          ),
          const SizedBox(width: 10),
          Text(
            'Rs. ${int.parse(orderLines.price!) * int.parse(orderLines.quantity!)}',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Color(0xff000000),
              fontWeight: FontWeight.w500,
            ),
            softWrap: false,
          )
        ],
      ),
    );
  }
}
