import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({super.key, required this.totalPrice});
  final int totalPrice;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  


  paymentConfig(){
      return  PaymentConfig(
    publishableApiKey: 'pk_test_PB1baNgjCqvDmTbqdZQMCKXTWQejHLM7NUxwwRLV',
    amount: widget.totalPrice*100, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    creditCard: CreditCardConfig(saveCard: true, manual: false),
  );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CreditCard(
          config: paymentConfig(),
          onPaymentResult: (PaymentResponse data) {
            print(data.id);
            print(data.amount);
            print(data.status.name);
            print(data.createdAt);
          },
        ),
      ),
    );
  }
}
