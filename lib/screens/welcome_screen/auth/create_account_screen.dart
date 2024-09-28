import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [Color(0xff87B1C5), Color(0x72FFFFFF), Color(0xffD7D2CB)],
            )),
          ),
          Image.asset("assets/images/pattren 1.png")
        ],
      ),
    );
  }
}
