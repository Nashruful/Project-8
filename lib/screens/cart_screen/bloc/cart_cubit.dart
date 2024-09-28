import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  double unitPrice = 12.0;
  int quantity = 1;

  CartCubit()
      : super(CartSuccess(totalPrice: 12.0, quantity: 1, unitPrice: 12.0));

  void increaseQuantity() {
    try {
      final currentQuantity =
          (state is CartSuccess) ? (state as CartSuccess).quantity : quantity;
      final updatedQuantity = currentQuantity + 1;

      emit(CartSuccess(
        totalPrice: unitPrice * updatedQuantity,
        quantity: updatedQuantity,
        unitPrice: unitPrice,
      ));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void decreaseQuantity() {
    try {
      final currentQuantity =
          (state is CartSuccess) ? (state as CartSuccess).quantity : quantity;
      final updatedQuantity = currentQuantity > 1 ? currentQuantity - 1 : 1;

      emit(CartSuccess(
        totalPrice: unitPrice * updatedQuantity,
        quantity: updatedQuantity,
        unitPrice: unitPrice,
      ));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }

  void setUnitPrice(double newPrice) {
    try {
      final currentQuantity =
          (state is CartSuccess) ? (state as CartSuccess).quantity : quantity;

      emit(CartSuccess(
        totalPrice: newPrice * currentQuantity,
        quantity: currentQuantity,
        unitPrice: newPrice,
      ));
    } catch (e) {
      emit(CartError(message: e.toString()));
    }
  }
}
