import 'dart:convert';

import 'package:ash_app/model/category.dart';
import 'package:ash_app/model/product.dart';
import 'package:ash_app/utils/baseurl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> filterProducts = [];
  List<Product> filterCatProducts = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCategories();
    fetchAllProducts();
  }

  fetchAllCategories() async {
    var url = Uri.parse('${baseurl}categories/getAllCategories.php');
    var res = await http.get(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      categories = AllCategories.fromJson(response).category!;
    }

    update();
  }

  fetchAllProducts() async {
    var url = Uri.parse('${baseurl}products/getAllProducts.php');
    var res = await http.get(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      products = AllProducts.fromJson(response).data!;
    }

    update();
  }

  List<Product> getFilteredMenu(catId, merchantId) {
    return products
        .where((element) =>
            element.categoryId == catId && element.merchantId == merchantId)
        .toList();
  }

  search(String val) {
    if (val.isNotEmpty) {
      filterProducts = products
          .where((product) =>
              product.name!.toLowerCase().contains(val.toLowerCase()) ||
              product.price!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filterProducts = [];
    }
    update();
  }

  searchCatProduct(String val) {
    if (val.isNotEmpty) {
      filterCatProducts = products
          .where((product) =>
              product.name!.toLowerCase().contains(val.toLowerCase()) ||
              product.price!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filterCatProducts = [];
    }
    update();
  }
}
