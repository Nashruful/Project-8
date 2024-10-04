import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3D6B7D), // --------- for now -------
      appBar: AppBar(
        title: Text("Hello ${getIt.get<DataLayer>().currentUserInfo?['name']}"),
        //------------------ or put custom appbar ---------------

        iconTheme: const IconThemeData(color: Color(0xffF4F4F4)),
        actions: [
          IconButton(
              onPressed: () {
                //navigate to cart
              },
              icon: Badge.count(
                  backgroundColor: const Color(0xffA8483D),
                  count: 1, //changes accorfing to order items quantity
                  child: SvgPicture.asset(
                      'assets/svg/cart.svg'))), //change it after adding assets folder
          const SizedBox(
            width: 20,
          ),
        ],

        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
      ),
      drawer: const Drawer(
        child: Padding(padding: EdgeInsets.only(left: 30)),
      ), // ----------- custom drawer --------------

      body: CustomBackgroundContainer(
        child: SafeArea(
            child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(79, 255, 255, 255),
                          hintText: 'What would you like to order?',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(213, 255, 255, 255),
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.search,
                              color: Color(0xffF4F4F4)),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 5),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Open filter
                      },
                      icon: SvgPicture.asset('assets/svg/filter.svg'),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Swiper(
                layout: SwiperLayout.CUSTOM,
                customLayoutOption:
                    CustomLayoutOption(startIndex: -1, stateCount: 3)
                      ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                      ..addTranslate([
                        const Offset(-490.0, -30.0),
                        const Offset(0.0, 0.0),
                        const Offset(490.0, 30.0)
                      ]),
                itemWidth: double.infinity,
                itemHeight: 600,
                itemBuilder: (context, index) {
                  return const CoffeeCard(
                    name: 'Cappuccino',
                    price: 12,
                    imgURL:
                        'https://i.postimg.cc/fRgnzCYm/image-from-rawpixel-id-15496747-png-2-1.png',
                  );
                },
                itemCount: 10,
              )
            ],
          ),
        )),
      ),
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final double price;
  final String imgURL;

  const CoffeeCard({
    super.key,
    required this.name,
    required this.price,
    required this.imgURL,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/star.svg',
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontSize: 32,
                      color: Color(0xffF4F4F4),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '${price.toString()} SAR',
              style: const TextStyle(fontSize: 16, color: Color(0xffF4F4F4)),
            ),
            const SizedBox(height: 10),
            Image.network(
              imgURL,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 400, 0, 0),
          child: Positioned(
            child: ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.white),
                  backgroundColor: WidgetStateProperty.all(
                      const Color(0xff3D6B7D)) //whats the new way for this?
                  ),
              onPressed: () {
                //add to cart
              },
              child: const Text('+ Add To Cart'),
            ),
          ),
        ),
      ],
    );
  }
}
