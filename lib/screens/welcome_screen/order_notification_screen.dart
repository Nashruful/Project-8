import 'package:flutter/material.dart';

class OrderNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFCBD9DF),
      body: Stack(
        children: [
          Positioned(
            bottom: 3,
            top: 130,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                    SizedBox(height: 90),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Almost There!',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3D6B7D),
                          ),
                        ),
                        Text(
                          'There are a couple of orders ahead \n of you, so you\'ll need to wait for about 3 minutes. Would you like to proceed with your order?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF3D6B7D),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3D6B7D),
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 90),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.5),
                        ),
                      ),
                      child: Text(
                        'Proceed To Payment',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
