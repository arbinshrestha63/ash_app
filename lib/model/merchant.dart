class AllMerchants {
  bool? success;
  String? message;
  List<Merchant>? data;

  AllMerchants({this.success, this.message, this.data});

  AllMerchants.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Merchant>[];
      json['data'].forEach((v) {
        data!.add(Merchant.fromJson(v));
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

class Merchant {
  String? id;
  String? name;
  String? contact;
  String? address;
  String? email;
  String? password;
  String? image;

  Merchant(
      {this.id,
      this.name,
      this.contact,
      this.address,
      this.email,
      this.password,
      this.image});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contact = json['contact'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['contact'] = contact;
    data['address'] = address;
    data['email'] = email;
    data['password'] = password;
    data['image'] = image;
    return data;
  }
}
