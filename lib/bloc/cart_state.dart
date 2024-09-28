class CartState {
  final int quantity;
  final double unitPrice;
  final double totalPrice;

  CartState({required this.quantity, required this.unitPrice})
      : totalPrice = quantity * unitPrice;
}
