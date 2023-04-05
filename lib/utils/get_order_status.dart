import 'package:ash_app/utils/status.dart';
import 'package:flutter/material.dart';

getOrderStatus(status) {
  switch (status) {
    case OrderStatus.pending:
      return {'status': 'Pending', 'color': Colors.blue};
    case OrderStatus.accepted:
      return {'status': 'Accepted', 'color': Colors.amber};
    case OrderStatus.completed:
      return {'status': 'Completed', 'color': Colors.green};
    case OrderStatus.cancelled:
      return {'status': 'Cancelled', 'color': Colors.red};
    default:
      return {'status': 'Pending', 'color': Colors.blue};
  }
}
