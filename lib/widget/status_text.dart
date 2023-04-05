import 'package:ash_app/utils/get_order_status.dart';
import 'package:flutter/cupertino.dart';

class StatusText extends StatelessWidget {
  const StatusText({super.key, this.status = '0'});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            color: getOrderStatus(status)['color'],
            borderRadius:
                const BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          getOrderStatus(status)['status'],
          style: const TextStyle(
            fontSize: 14,
          ),
        )
      ],
    );
  }
}
