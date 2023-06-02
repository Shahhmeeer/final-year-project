import 'package:flutter/material.dart';

import '../models/product_model.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get() => [..._products];

  void addProducts(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
