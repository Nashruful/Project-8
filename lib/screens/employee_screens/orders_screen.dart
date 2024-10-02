
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/screens/employee_screens/order_state_screen.dart';
import 'package:onze_cofe_project/components/lists/custom_orders_list_tile.dart';
import 'package:onze_cofe_project/screens/employee_screens/bloc/order_state_bloc.dart';
import 'package:onze_cofe_project/screens/employee_screens/order_state_screen.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderStateBloc()..add(FetchOrdersEvent()),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffF4F4F4),
            foregroundColor: const Color(0xff3D6B7D),
            title: const Text(
              "Orders",
              style: TextStyle(
                color: Color(0xff3D6B7D),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu_rounded),
            ),
            bottom: const TabBar(
              indicatorColor: Color(0xff87B1C5),
              labelColor: Color(0xff3D6B7D),
              unselectedLabelColor: Color(0xff4A7585),
              tabs: [
                Text(
                  "Current orders",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Completed orders",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildOrdersTab(),
              buildOrdersTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrdersTab() {
    return BlocBuilder<OrderStateBloc, OrderStateState>(
      builder: (context, state) {
        if (state is OrderStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is OrderStateFailure) {
          return Center(child: Text('Error: ${state.error}'));
        } else if (state is OrderStateLoaded) {
          final orders = state.orders;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: orders.length,
            separatorBuilder: (context, index) => const Divider(
              color: Color(0xffD7D1CA),
            ),
            itemBuilder: (context, index) {
              final order = orders[index];
              final orderId = order['order_id'];

              return CustomOrdersListTile(
                text: "Order #$orderId",
                icon: Icons.watch_later_outlined,
                color: const Color(0xffA8483D),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OrderStateScreen()));
                },
              );
            },
          );
        } else {
          return const Center(child: Text('No Orders Found'));
        }
      },
    );
  }
}
