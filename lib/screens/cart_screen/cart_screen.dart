import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/item/cartItem.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/order_notification_screen.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

import 'cubit/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cartItems =
        getIt.get<DataLayer>().viewCartItems();

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
          backgroundColor: const Color(0xff3D6B7D),
        ),
        body: CustomBackgroundContainer(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: cartItems.isEmpty
                      ? const Center(
                          child:  Text(
                          'Your cart is empty.',
                          style: TextStyle(color: Color(0xfff4f4f4)),
                        ))
                      : Column(
                          children: cartItems
                              .map((item) => CartItem(
                                    name: item['name'],
                                    price:
                                        double.parse(item['price'].toString()),
                                    imgUrl: item['image_url'],
                                  ))
                              .toList(),
                        ),
                ),
              ),
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
                    //showBottomSheet(context: context, builder: (context))
                    //Navigator.of(context).push(createRouteToCart());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA8483D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
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

//?????
Route createRouteToCart() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        const OrderNotificationScreen(),
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
