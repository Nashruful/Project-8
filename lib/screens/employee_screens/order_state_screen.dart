import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onze_cofe_project/components/app_bar/custom_app_bar.dart';
import 'package:onze_cofe_project/components/containers/custom_order_container.dart';
import 'package:onze_cofe_project/components/custom_elevated_button/custom_elevated_button.dart';
import 'package:onze_cofe_project/components/custom_text/custom_text.dart';
import 'package:onze_cofe_project/screens/employee_screens/bloc/order_state_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/containers/custom_background_container.dart';

class OrderStateScreen extends StatelessWidget {
  const OrderStateScreen({
    super.key,
    required this.orderID,
    required this.userName,
    required this.userID,
  });
  final int orderID;
  final String userName;
  final String userID;

  String formatTime(int seconds) {
    int minutes = (seconds / 60).floor();
    int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderStateBloc(),
      child: Builder(builder: (context) {
        context
            .read<OrderStateBloc>()
            .add(GetOrdersItemEvent(orderID: orderID));
        return CustomBackgroundContainer(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: CustomAppBar(text: "Order\n #${orderID.toString()}"),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: BlocBuilder<OrderStateBloc, OrderStateState>(
                  builder: (context, state) {
                    if (state is OrdersItemState) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView(
                              children: [
                                CustomText(
                                  text: "Name: $userName",
                                  color: const Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                Column(
                                  children: state.orderItem.map((item) {
                                    final totalPrice = item['product']
                                            ['price'] *
                                        item['quantity'];
                                    print("Item: $item");
                                    return CustomOrderContainer(
                                      image: Image.network(
                                        item['product']['image_url'],
                                        fit: BoxFit.contain,
                                      ),
                                      title: item['product']['name'],
                                      subtitle: "${totalPrice.toString()} SAR",
                                      quantity:
                                          "X ${item['quantity'].toString()}",
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {
                                  context
                                      .read<OrderStateBloc>()
                                      .add(StartTimerEvent(orderID: orderID));
                                },
                                child: const CustomText(
                                    text: "Start",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (state is RunningState) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Name: $userName",
                                  color: const Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          "assets/json/Animation - 1728142372274.json",
                                          width: 300,
                                          height: 300),
                                      CustomText(
                                          text: formatTime(state.seconds),
                                          color: const Color(0xffF4F4F4),
                                          size: 30),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {
                                  context
                                      .read<OrderStateBloc>()
                                      .add(StopTimerEvent(orderID: orderID));

                                  Navigator.pop(context);
                                },
                                child: const CustomText(
                                    text: "Done",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    } else if (state is StoppedState) {
                      return Column(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Name: $userName",
                                  color: const Color(0xffF4F4F4),
                                  size: 20,
                                  weight: FontWeight.w600,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      Lottie.asset(
                                          "assets/json/Animation - 1728142372274.json",
                                          width: 300,
                                          height: 300),
                                      const CustomText(
                                          text: "Time's up!",
                                          color: Color(0xffFBFBFB),
                                          size: 20),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              width: 287,
                              child: CustomElevatedButton(
                                backgroundColor: const Color(0xffA8483D),
                                onPressed: () {
                                  context
                                      .read<OrderStateBloc>()
                                      .add(StopTimerEvent(orderID: orderID));

                                  Navigator.pop(context);
                                },
                                child: const CustomText(
                                    text: "Done",
                                    color: Color(0xffF4F4F4),
                                    size: 16),
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Lottie.asset(
                            "assets/json/Animation - 1728142372274.json"),
                      );
                    }
                  },
                ),
              )),
        );
      }),
    );
  }
}
