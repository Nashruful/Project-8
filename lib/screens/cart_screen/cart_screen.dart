import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:onze_cofe_project/components/items/cart_Item.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/cart_screen/model/cartItemDate.dart';
import 'package:onze_cofe_project/screens/notification_screen/order_notification_screen.dart';
import 'cubit/cart_cubit.dart';
import 'package:get_it/get_it.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> cartItems =
        GetIt.I.get<DataLayer>().viewCartItems();
    List<CartItemData> cartItemDataList = cartItems.map((item) {
      return CartItemData(
        id: item['id'],
        name: item['name'],
        unitPrice: item['unitPrice'],
        quantity: item['quantity'],
      );
    }).toList();
    return BlocProvider(
      create: (context) => CartCubit(cartItemDataList),
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
                          child: Text(
                            'Your cart is empty.',
                            style: TextStyle(color: Color(0xfff4f4f4)),
                          ),
                        )
                      : Column(
                          children: cartItems.asMap().entries.map((entry) {
                            final index =
                                entry.key; 
                            return CartItem(
                              key: ValueKey(entry.value),
                              name: entry.value['name'],
                              price: entry.value['unitPrice'],
                              imgUrl: entry.value['imgUrl'],
                              index: index,
                              onIncrement: () {
                                GetIt.I
                                    .get<DataLayer>()
                                    .incrementItemQuantity(item: entry.value);
                              },
                              onDecrement: () {
                                GetIt.I
                                    .get<DataLayer>()
                                    .decrementItemQuantity(item: entry.value);
                                context.read<CartCubit>().decreaseQuantity(
                                    index); 
                              },
                            );
                          }).toList(),
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
                    final totalPrice = state.cartItems.fold(0.0,
                        (sum, item) => sum + item.unitPrice * item.quantity);
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
                            "${totalPrice.toStringAsFixed(2)} SAR",
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    backgroundColor: const Color(0xFF336B87),
                  ),
                  child: const Text("Place Order"),
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
