class AllProducts {
  bool? success;
  List<String>? message;
  List<Product>? data;

  AllProducts({this.success, this.message, this.data});

  AllProducts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].cast<String>();
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(Product.fromJson(v));
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

class Product {
  String? id;
  String? name;
  String? categoryId;
  String? price;
  String? image;
  String? merchantId;
  String? date;
  String? description;
  String? isDeleted;
  String? merchantName;

  Product(
      {this.id,
      this.name,
      this.categoryId,
      this.price,
      this.image,
      this.merchantId,
      this.date,
      this.description,
      this.isDeleted,
      this.merchantName});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryId = json['category_id'];
    price = json['price'];
    image = json['image'];
    merchantId = json['merchant_id'];
    date = json['date'];
    description = json['description'];
    isDeleted = json['is_deleted'];
    merchantName = json['merchant_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category_id'] = categoryId;
    data['price'] = price;
    data['image'] = image;
    data['merchant_id'] = merchantId;
    data['date'] = date;
    data['description'] = description;
    data['is_deleted'] = isDeleted;
    data['merchant_name'] = merchantName;
    return data;
  }
}
