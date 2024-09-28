import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class CartEvent {}

class IncreaseQuantityEvent extends CartEvent {}

class DecreaseQuantityEvent extends CartEvent {}

// State
class CartState {
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  CartState({required this.quantity, required this.unitPrice})
      : totalPrice = quantity * unitPrice;
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(quantity: 1, unitPrice: 12)) {
    on<IncreaseQuantityEvent>((event, emit) {
      final updatedQuantity = state.quantity + 1;
      emit(CartState(quantity: updatedQuantity, unitPrice: state.unitPrice));
    });

    on<DecreaseQuantityEvent>((event, emit) {
      final updatedQuantity = state.quantity > 1 ? state.quantity - 1 : 1;
      emit(CartState(quantity: updatedQuantity, unitPrice: state.unitPrice));
    });
  }
}
