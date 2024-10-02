import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onze_cofe_project/components/drawer/custom_drawer.dart';
import 'package:onze_cofe_project/screens/cart_screen/cart_screen.dart';
import 'package:onze_cofe_project/screens/contact_us_screen/contact_us.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(139, 166, 177, 1),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: () {
                //  Navigator.of(context).push(ContactUsPage());
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CartScreen()));
                },
                icon: Image.asset(
                  'assets/images/cart.png',
                  height: 32,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                top: 15,
                right: 10,
                child: Image.asset(
                  'assets/images/dot.png',
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(139, 166, 177, 1),
              Color.fromRGBO(100, 137, 151, 1),
              Color.fromRGBO(61, 107, 125, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 10,
              left: -60,
              right: -60,
              child: Image.asset(
                'assets/images/coffee_cup.png',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
