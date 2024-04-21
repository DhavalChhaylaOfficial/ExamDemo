import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:ecomm/Model/cart_model.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF437bfb),
        title: Text('Home',style: TextStyle(color: Colors.white),),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            ProductCard(
              productName: 'Apple',
              price: 20.0,
              imagePath: 'assets/images/apple.png',
            ),
            ProductCard(
              productName: 'Banana',
              price: 40.0,
              imagePath: 'assets/images/banana.png',
            ),
            ProductCard(
              productName: 'orange',
              price: 20.0,
              imagePath: 'assets/images/orange.png',
            ),
            ProductCard(
              productName: 'Melon',
              price: 40.0,
              imagePath: 'assets/images/watermelon.png',
            ),
            ProductCard(
              productName: 'Avocado',
              price: 25.0,
              imagePath: 'assets/images/avocado.png',
            ),
            ProductCard(
              productName: 'Kiwi',
              price: 50.0,
              imagePath: 'assets/images/kiwi.png',
            ),
            ProductCard(
              productName: 'Grapes',
              price: 15.0,
              imagePath: 'assets/images/grapes.png',
            ),
            ProductCard(
              productName: 'Chocolate',
              price: 75.0,
              imagePath: 'assets/images/choc.png',
            ),
            ProductCard(
              productName: 'Pizza',
              price: 50.0,
              imagePath: 'assets/images/pizza.png',
            ),
            ProductCard(
              productName: 'Burgur',
              price: 30.0,
              imagePath: 'assets/images/burgur.png',
            ),
            ProductCard(
              productName: 'Fries',
              price: 35.55,
              imagePath: 'assets/images/fries.png',
            ),
            // Add more ProductCards here
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String productName;
  final double price;
  final String imagePath;

  const ProductCard({
    Key? key,
    required this.productName,
    required this.price,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(imagePath),
        title: Text(productName),
        subtitle: Text('\$$price'),
        trailing: ElevatedButton(
          onPressed: () {
            addToCart(context, productName, price); // Pass the price here
          },
          child: Text('Add to Cart'),
        ),
      ),
    );
  }

  void addToCart(BuildContext context, String productName, double price) {
    final cart = context.read<CartModel>();
    cart.addItem(productName, price); // Now pass the received price
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to Cart: $productName'),
        duration: Duration(seconds: 1),
      ),
    );
  }
}



class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart',style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF437bfb),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final itemName = cart.items.keys.elementAt(index);
              final itemQuantity = cart.items[itemName];
              final itemPrice = cart.getPriceByName(itemName);
              return ListTile(
                title: Text('$itemName x$itemQuantity'),
                subtitle: Text(
                    '\$${itemPrice != null ? itemPrice * itemQuantity! : 0}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    cart.removeItem(itemName);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${cart.getTotalPrice()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
