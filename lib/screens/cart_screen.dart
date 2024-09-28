import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/bloc/cart_bloc.dart';
import 'package:onze_cofe_project/bloc/cart_state.dart';
import 'package:onze_cofe_project/components/item/cartItem.dart';
import 'package:onze_cofe_project/screens/order_notification_screen.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text(
            "Cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: Color.fromRGBO(139, 166, 177, 1),
        ),
        backgroundColor: Color(0xFFEFEFEF),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(139, 166, 177, 1),
                Color.fromRGBO(100, 137, 151, 1),
                Color.fromRGBO(61, 107, 125, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 20),
              CartItem(),
              Spacer(),
              Center(
                child: Divider(
                  color: Colors.white70,
                  thickness: 2.5,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "${state.totalPrice} SAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createRouteToCart());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA8483D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  ),
                  child: Center(
                    child: Text(
                      "Place Order",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Route createRouteToCart() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        OrderNotificationScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); 
      const end = Offset.zero; 
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
