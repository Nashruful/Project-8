import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/components/containers/custom_background_container.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onze_cofe_project/screens/Home_screen/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String? selectedFilter;

    void onFilterSelected(String filter) {
      {
        if (selectedFilter == filter) {
          // If the filter is already selected, do nothing
          return;
        } else {
          // Select the new filter
          selectedFilter = filter;
        }
      }
    }

    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<HomeBloc>();
        bloc.add(LoadScreenEvent());
        return BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const AlertDialog(
                  backgroundColor: Colors.transparent,
                  //    content: Lottie.asset(""), ======= PUT LOADING ANIMATION HERE
                ),
              );
            } else if (state is SuccessState) {
              Navigator.pop(context, true);
            } else if (state is ErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'error',
                    style: TextStyle(color: Color(0xFF4E2EB5)),
                  ),
                  backgroundColor: Colors.white,
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xff3D6B7D),
            appBar: AppBar(
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
                        child: SvgPicture.asset('assets/svg/cart.svg'))),
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
              child: Center(
                child: Wrap(
                  children: [
                    const SizedBox(
                      height: 40, //===============
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(79, 255, 255, 255),
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
                              showModalBottomSheet<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 400,
                                    color: const Color(0xfff4f4f4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextButton(
                                          onPressed: () =>
                                              onFilterSelected('All'),
                                          child: Text(
                                            'All',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: selectedFilter == 'All'
                                                  ? Colors.blue
                                                  : const Color(0xff467283),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              onFilterSelected('Hot Drinks'),
                                          child: Text(
                                            'Hot Drinks',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color:
                                                  selectedFilter == 'Hot Drinks'
                                                      ? Colors.blue
                                                      : const Color(0xff467283),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              onFilterSelected('Cold Drinks'),
                                          child: Text(
                                            'Cold Drinks',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: selectedFilter ==
                                                      'Cold Drinks'
                                                  ? Colors.blue
                                                  : const Color(0xff467283),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => onFilterSelected(
                                              'Pour Over Coffee'),
                                          child: Text(
                                            'Pour Over Coffee',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: selectedFilter ==
                                                      'Pour Over Coffee'
                                                  ? Colors.blue
                                                  : const Color(0xff467283),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              onFilterSelected('Tea'),
                                          child: Text(
                                            'Tea',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: selectedFilter == 'Tea'
                                                  ? Colors.blue
                                                  : const Color(0xff467283),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon: SvgPicture.asset('assets/svg/filter.svg'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                      if (state is SuccessState) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 160),
                              child: Container(
                                height: 370,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(200),
                                      topRight: Radius.circular(200)),
                                  color: Color(0xffD8D3CC),
                                ),
                              ),
                            ),
                            Swiper(
                                duration: 1000,
                                autoplay: true,
                                autoplayDelay: 7000,
                                layout: SwiperLayout.CUSTOM,
                                customLayoutOption: CustomLayoutOption(
                                    startIndex: -1, stateCount: 3)
                                  ..addRotate([-90.0 / 180, 0.0, 90.0 / 180])
                                  ..addTranslate([
                                    const Offset(-490.0, -30.0),
                                    const Offset(0.0, 0.0),
                                    const Offset(490.0, -30.0)
                                  ]),
                                itemWidth: double.infinity,
                                itemHeight: 600,
                                itemBuilder: (context, index) {
                                  final item = bloc.items[index];
                                  return CoffeeCard(
                                    name: item['name'],
                                    price:
                                        double.parse(item['price'].toString()),
                                    imgURL: item['image_url'],
                                  );
                                },
                                itemCount: bloc.items.length,
                                pagination: const SwiperPagination(
                                  builder: FractionPaginationBuilder(
                                      activeColor: Color(0xffFFFFFF),
                                      color: Color.fromARGB(119, 255, 255, 255),
                                      fontSize: 12,
                                      activeFontSize: 16),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 450),
                              child: Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffA8483D)),
                                      onPressed: () {},
                                      child: const Text(
                                        '+ Add To Cart',
                                        style:
                                            TextStyle(color: Color(0xfff4f4f4)),
                                      )),
                                  const Spacer(),
                                  const Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        color:
                                            Color.fromARGB(192, 244, 244, 244),
                                      ),
                                      Text(
                                        '5',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                200, 244, 244, 244)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox();
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      }),
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
    return ClipRect(
        child: Align(
      alignment: Alignment.topCenter,
      //heightFactor: ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg/star.svg',
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: const TextStyle(
                    fontSize: 32,
                    color: Color(0xffF4F4F4),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${price.toString()} SAR',
            style: const TextStyle(fontSize: 16, color: Color(0xffF4F4F4)),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SizedBox(
              height: 400,
              child: Image.network(
                imgURL,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
