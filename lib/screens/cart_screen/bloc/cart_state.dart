part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {
  CartInitial();
}

final class CartLoading extends CartState {}

final class CartSuccess extends CartState {
  final double totalPrice;
  final int quantity;
  final double unitPrice;

  CartSuccess(
      {required this.totalPrice,
      required this.quantity,
      required this.unitPrice});
}

final class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
