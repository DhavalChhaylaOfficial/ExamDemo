import 'package:ecomm/ui/Screens/home_page.dart';
import 'package:ecomm/ui/Screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Model/cart_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(), // Provide your CartModel here
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Your App Title',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(
                controller: PageController(),
              ),
          '/': (context) => HomePage(),
          '/cart': (context) => CartPage(),
        },
      ),
    );
  }
}
