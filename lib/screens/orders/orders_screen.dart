import 'package:ash_app/utils/theme.dart';
import 'package:ash_app/widget/order_row.dart';
import 'package:ash_app/widget/status_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ash_app/controllers/order_controller.dart';
import 'package:ash_app/model/orders.dart';
import 'package:ash_app/utils/decoration.dart';
import 'package:ash_app/utils/status.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: AppMainTheme.primaryColor),
          title: const Text(
            'My Orders',
            style: TextStyle(
              fontSize: 23,
              color: AppMainTheme.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                controller.fetchOrders();
              },
              icon: const Icon(
                Icons.refresh,
                color: AppMainTheme.primaryColor,
              ),
            )
          ],
        ),
        body: DefaultTabController(
          length: 2,
          child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const TabBar(
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          labelStyle:
                              TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                          indicatorColor: AppMainTheme.primaryColor,
                          tabs: [
                            Tab(text: 'Today'),
                            Tab(text: 'All Orders'),
                          ],
                        ),
                        Expanded(
                            child: TabBarView(
                          children: [true, false]
                              .map((e) => SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: controller
                                          .getTodayOrders(e)
                                          .map((e) => Slidable(
                                                endActionPane:
                                                    e.status !=
                                                            OrderStatus.pending
                                                        ? null
                                                        : ActionPane(
                                                            motion:
                                                                const ScrollMotion(),
                                                            children: [
                                                              SlidableAction(
                                                                onPressed: (a) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Cancel Order'),
                                                                          content:
                                                                              const Text('Are you sure you want to cancel this order? You won\'t be refunded'),
                                                                          actions: [
                                                                            ElevatedButton(
                                                                              child: const Text('Yes'),
                                                                              onPressed: () {
                                                                                controller.changeOrderStatus(OrderStatus.cancelled, e.id);
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('No', style: TextStyle(color: Colors.white)),
                                                                            )
                                                                          ],
                                                                        );
                                                                      });
                                                                },
                                                                backgroundColor:
                                                                    const Color(
                                                                        0xFFff0000),
                                                                foregroundColor:
                                                                    Colors
                                                                        .white,
                                                                icon: FontAwesomeIcons
                                                                    .trashAlt,
                                                                label: 'Cancel',
                                                              ),
                                                            ],
                                                          ),
                                                child: OrderCard(order: e),
                                              ))
                                          .toList(),
                                    ),
                                  ))
                              .toList(),
                        ))
                      ],
                    )),
        ),
      );
    });
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order: #${order.id}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    order.date!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    'Total: Rs. ${order.totalCost}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  StatusText(
                    status: order.status!,
                  ),
                  Text(
                    'Paid: ${order.isPaid == '1' ? 'Yes' : 'No'}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: Color(0xff000000),
                    ),
                    softWrap: false,
                  ),
                ],
              ),
            ],
          ),
          const Text(
            'Restaurant: Almonds',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ...order.orderLines!
              .map((e) => OrderRow(
                    orderLines: e,
                  ))
              .toList()
        ],
      ),
    );
  }
}
