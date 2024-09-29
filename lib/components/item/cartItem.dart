import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/screens/cart_screen/cubit/cart_cubit.dart';

class CartItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/images/download.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cappuccino",
                    style: TextStyle(
                      color: Color.fromRGBO(61, 107, 125, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 5),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                     
                      if (state is CartSuccess) {
                        return Text(
                          "${state.unitPrice.toStringAsFixed(2)} SAR",
                          style: TextStyle(
                            color: Color(0xff3D6B7D)
,                            fontSize: 16,
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF336B87),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        context.read<CartCubit>().increaseQuantity();
                      },
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        if (state is CartSuccess) {
                          return Text(
                            "${state.quantity}",
                            style: TextStyle(color: Colors.white),
                          );
                        }
                       
                        return Container();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.remove, color: Colors.white),
                      onPressed: () {
                        context.read<CartCubit>().decreaseQuantity();
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
