// import 'dart:async';

// import 'package:bloc/bloc.dart';
// import 'package:meta/meta.dart';

// part 'order_state_event.dart';
// part 'order_state_state.dart';

// class OrderStateBloc extends Bloc<OrderStateEvent, OrderStateState> {

//   Timer? timer;

//   OrderStateBloc() : super(OrderStateInitial()) {
//     on<OrderStateEvent>((event, emit) {});

//     on<StartTimerEvent>((event, emit) {
//       startTimer(60);
//       emit(RunningState(seconds: 60));
//     });

//     on<RunTimerEvent>((event, emit) {
//       if (state is RunningState) {
//         final seconds = (state as RunningState).seconds - 1;
//         if (seconds > 0) {
//           emit(RunningState(seconds: seconds));
//         } else {
//           emit(StoppedState());
//         }
//       }
//     });

//     on<StopTimerEvent>((event, emit) {
//       timer?.cancel();
//     });
//   }

//   void startTimer(int seconds) {
//     timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       add(RunTimerEvent());
//     });
//   }

//   @override
//   Future<void> close() {
//     timer?.cancel();
//     return super.close();
//   }
// }

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onze_cofe_project/data_layer/data_layer.dart';
import 'package:onze_cofe_project/screens/auth/cubit/auth_cubit.dart';
import 'package:onze_cofe_project/setup/setup_init.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'order_state_event.dart';
part 'order_state_state.dart';

class OrderStateBloc extends Bloc<OrderStateEvent, OrderStateState> {
  Timer? timer;
  final supabase = getIt.get<DataLayer>().supabase;
  OrderStateBloc() : super(OrderStateInitial()) {
    //on<FetchOrdersEvent>(onFetchOrders);

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
      emit(StoppedState());
    });
    on<FetchOrdersEvent>((event, emit) async {
       emit(OrderStateLoading());

    try {
      final response =
          await Supabase.instance.client.from('orders').select('order_id');
          emit(OrderStateLoaded(response));
      // supabase.from('orders').select('order_id');
// final orders = respponse
      // if (response.error != null) {
      //   emit(OrderStateFailure(response.error!.message));
      // } else {
      //   final orders = response.data as List<dynamic>;
      //   emit(OrderStateLoaded(orders));
      //
      //
      //}
    } catch (e) {
      emit(OrderStateFailure(e.toString()));
    }
    });
  }

  // Timer functionality
  void startTimer(int seconds) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(RunTimerEvent());
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
//انا اضفت هذه فنكشن 
//   Future<void> onFetchOrders(
//       FetchOrdersEvent event, Emitter<OrderStateState> emit) async {
//     emit(OrderStateLoading());

//     try {
//       final response =
//           await Supabase.instance.client.from('orders').select('order_id');
//           emit(SuccessState() as OrderStateState);
//       // supabase.from('orders').select('order_id');
// // final orders = respponse
//       // if (response.error != null) {
//       //   emit(OrderStateFailure(response.error!.message));
//       // } else {
//       //   final orders = response.data as List<dynamic>;
//       //   emit(OrderStateLoaded(orders));
//       //
//       //
//       //}
//     } catch (e) {
//       emit(OrderStateFailure(e.toString()));
//     }
//   }
}
