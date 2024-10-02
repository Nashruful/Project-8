import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data_layer/data_layer.dart';
import '../../../setup/setup_init.dart';

part 'order_state_event.dart';
part 'order_state_state.dart';

class OrderStateBloc extends Bloc<OrderStateEvent, OrderStateState> {
  Timer? timer;
  final supabase = getIt.get<DataLayer>().supabase;

  OrderStateBloc() : super(OrderStateInitial()) {
    on<OrderStateEvent>((event, emit) {});

    on<StartTimerEvent>((event, emit) {
      startTimer(60);
      emit(RunningState(seconds: 60));
    });

    on<RunTimerEvent>((event, emit) {
      if (state is RunningState) {
        final seconds = (state as RunningState).seconds - 1;
        if (seconds > 0) {
          emit(RunningState(seconds: seconds));
        } else {
          emit(StoppedState());
        }
      }
    });

    on<StopTimerEvent>((event, emit) {
      timer?.cancel();
    });

    on<GetOrdersItemEvent>((event, emit) async {
      try {
        final orderID = await supabase
            .from('orders')
            .select('order_id')
            .eq('user_id', 'a57e1a5d-11ea-4237-a85c-f9504db3ad51');

            final userName = await supabase.from('users').select('name').eq('user_id', 'a57e1a5d-11ea-4237-a85c-f9504db3ad51');

        if (orderID.isNotEmpty) {
          final orderIDValue = orderID[0]['order_id'];
          
          final productIDResponse = await supabase
              .from("order_items")
              .select('product_id')
              .eq('order_id', orderIDValue);

          final productIDs = 
              productIDResponse.map((item) => item['product_id']).toList();

          final orderItems = [];
          for (var productID in productIDs) {
            final orderItem = await supabase
                .from('product')
                .select('image_url, name, price')
                .eq('product_id', productID);
            orderItems.addAll(orderItem);
          }

          emit(OrdersItemState(
              orderItem: List<Map<String, dynamic>>.from(orderItems), userName: userName[0]['name']));
        } else {
          emit(ErrorState(msg: 'No order ID found'));
        }
      } on FormatException catch (e) {
        emit(ErrorState(msg: e.message));
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });

    on<GetOrdersEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final response = await supabase.from('orders').select('order_id, status');
        final orderStatusValue = response.map((state)=> state['status']).toList();
        emit(OrdersState(orders: response, status: orderStatusValue));        
      } catch (e) {
        emit(ErrorState(msg: e.toString()));
      }
    });
  }

  void startTimer(int seconds) {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(RunTimerEvent());
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
