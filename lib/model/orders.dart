class AllOrders {
  bool? success;
  String? message;
  List<Order>? data;

  AllOrders({this.success, this.message, this.data});

  AllOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Order>[];
      json['data'].forEach((v) {
        data!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? id;
  String? date;
  String? totalCost;
  String? merchantId;
  String? status;
  String? isPaid;
  String? userId;
  String? merchantName;
  String? merchantContact;
  String? merchantAddress;
  List<OrderLines>? orderLines;

  Order(
      {this.id,
      this.date,
      this.totalCost,
      this.merchantId,
      this.status,
      this.isPaid,
      this.userId,
      this.merchantName,
      this.merchantContact,
      this.merchantAddress,
      this.orderLines});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    totalCost = json['total_cost'];
    merchantId = json['merchant_id'];
    status = json['status'];
    isPaid = json['is_paid'];
    userId = json['user_id'];
    merchantName = json['merchant_name'];
    merchantContact = json['merchant_contact'];
    merchantAddress = json['merchant_address'];
    if (json['order_lines'] != null) {
      orderLines = <OrderLines>[];
      json['order_lines'].forEach((v) {
        orderLines!.add(OrderLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['total_cost'] = totalCost;
    data['merchant_id'] = merchantId;
    data['status'] = status;
    data['is_paid'] = isPaid;
    data['user_id'] = userId;
    data['merchant_name'] = merchantName;
    data['merchant_contact'] = merchantContact;
    data['merchant_address'] = merchantAddress;
    if (orderLines != null) {
      data['order_lines'] = orderLines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderLines {
  String? orderDetailId;
  String? productId;
  String? name;
  String? price;
  String? image;
  String? description;
  String? catId;
  String? catName;
  String? quantity;
  String? lineTotal;

  OrderLines(
      {this.orderDetailId,
      this.productId,
      this.name,
      this.price,
      this.image,
      this.description,
      this.catId,
      this.catName,
      this.quantity,
      this.lineTotal});

  OrderLines.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['order_detail_id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    catId = json['cat_id'];
    catName = json['cat_name'];
    quantity = json['quantity'];
    lineTotal = json['line_total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_detail_id'] = orderDetailId;
    data['product_id'] = productId;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['description'] = description;
    data['cat_id'] = catId;
    data['cat_name'] = catName;
    data['quantity'] = quantity;
    data['line_total'] = lineTotal;
    return data;
  }
}
