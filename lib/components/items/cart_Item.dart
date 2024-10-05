import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/screens/cart_screen/cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.index,
    required this.onIncrement,
    required this.onDecrement,
  });

  final String name;
  final double price;
  final String imgUrl;
  final int index;
  final void Function() onIncrement;
  final void Function() onDecrement;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.network(
                imgUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Color.fromRGBO(61, 107, 125, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      if (state is CartSuccess) {
                        final item = state.cartItems[index];
                        return Text(
                          "${(item.unitPrice * item.quantity).toStringAsFixed(2)} SAR", //  total price calculation per item
                          style: const TextStyle(
                            color: Color(0xff3D6B7D),
                            fontSize: 16,
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF336B87),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        context.read<CartCubit>().increaseQuantity(
                            index); // Increments quantity  items
                      },
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state is CartSuccess) {
                          final item = state.cartItems[index];
                          return Text(
                            "${item.quantity}", // Display  quantity
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 16,
                      ),
                      onPressed: () {
                        context
                            .read<CartCubit>()
                            .decreaseQuantity(index); // Decrements  items
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
