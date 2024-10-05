import 'package:flutter/material.dart';
import 'package:onze_cofe_project/screens/cart_screen/cart_screen.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 0.9),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(0),
          bottomLeft: Radius.circular(0),
        ),
      ),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 160),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                createDrawerHeader(),
                createDrawerItem(
                  text: 'Go to Cart',
                  onTap: () {
                    Navigator.of(context).push(createRouteToCart());
                  },
                ),
                createDrawerItem(
                  text: 'Track Orders',
                  onTap: () {},
                ),
                createDrawerItem(
                  text: 'Previous Orders',
                  onTap: () {},
                ),
                createDrawerItem(
                  text: 'Contact Us',
                  onTap: () {},
                ),
                createDrawerItem(
                  text: 'Sign out',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createDrawerHeader() {
    return ListTile(
      title: Row(
        children: <Widget>[
          Image.asset('assets/images/star.png'),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Hello,$name',
              style: TextStyle(
                color: Color.fromRGBO(61, 107, 125, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createDrawerItem({
    required String text,
    GestureTapCallback? onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(61, 107, 125, 1),
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

Route createRouteToCart() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const CartScreen(),
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
