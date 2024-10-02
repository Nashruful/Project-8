import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/items/cart_Item.dart';
import 'package:onze_cofe_project/screens/order_notification_screen.dart';


import 'cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          centerTitle: true,
          title: const Text(
            "Cart",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          backgroundColor: const Color.fromRGBO(139, 166, 177, 1),
        ),
        backgroundColor: const Color(0xFFEFEFEF),
        body: Container(
          decoration: const BoxDecoration(
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
              const SizedBox(height: 20),
              CartItem(), 
              const Spacer(),
              const Center(
                child: Divider(
                  color: Colors.white70,
                  thickness: 2.5,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CartSuccess) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            "${state.totalPrice.toStringAsFixed(2)} SAR",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CartError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(createRouteToCart());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA8483D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  ),
                  child: const Center(
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
