import 'package:flutter/material.dart';
import 'package:inttest/model/items.dart';

class ItemsAddModel extends ChangeNotifier {
  List<Result> _products = [];
  List<Result> _products2 = [];
  double _total = 0;

  List<Result> get allProducts => _products;

  void add(Result result) {
    _products2.add(result);
    _total += result.price!;
    notifyListeners();
  }

  void delete(Result result) {
    _total -= result.price!;
    _products2.remove(result);
    notifyListeners();
  }

  double get total {
    return _total;
  }

  List<Result> get shoppingCard {
    return _products2;
  }

  void addProduct(Result result) {
    _products.add(result);
    notifyListeners();
  }

  void deleteProduct(Result result) {
    _products.remove(result);
    notifyListeners();
  }

  int get count {
    return _products.length;
  }

  int get countadd {
    return _products2.length;
  }
}

// class Product {
//   String? productName;
//   int? price;
//   bool? isCompleted;
//   Product({this.isCompleted, this.price,  this.productName});
// }
