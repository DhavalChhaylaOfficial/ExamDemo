import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  Map<String, int> items = {};
  final Map<String, double> itemPrices = {
    'Apple': 20.0,
    'Banana': 40.0,
    'orange': 20.0,
    'Melon': 40.0,
    'Avocado': 25.0,
    'Kiwi': 50.0,
    'Grapes': 15.0,
    'Chocolate': 75.0,
    'Pizza':50.0,
    'Burgur':30.0,
    'Fries':35.55
  }; // Map to store item names and their quantities

  void addItem(String name, double price) {
    items.update(name, (value) => value + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void removeItem(String name) {
    if (items.containsKey(name)) {
      if (items[name]! > 1) {
        items.update(name, (value) => value - 1);
      } else {
        items.remove(name);
      }
      notifyListeners();
    }
  }

  double getTotalPrice() {
    double total = 0;
    items.forEach((name, quantity) {
      // Multiply the price by quantity for each item
      total += getPriceByName(name) * quantity;
    });
    return total;
  }

  // Helper function to get price by item name
  double getPriceByName(String name) {
    return itemPrices[name] ?? 0.0;
  }
}
