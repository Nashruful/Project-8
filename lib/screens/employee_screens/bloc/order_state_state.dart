part of 'order_state_bloc.dart';

sealed class OrderStateState {}

final class OrderStateInitial extends OrderStateState {}

final class RunningState extends OrderStateState {
  final int seconds;
  RunningState({required this.seconds});
}

final class StoppedState extends OrderStateState {}
// اضافتي 

final class OrderStateLoading extends OrderStateState {}



class OrderStateLoaded extends OrderStateState {
  final List<dynamic> orders;

  OrderStateLoaded(this.orders);
}

class OrderStateFailure extends OrderStateState {
  final String error;

  OrderStateFailure(this.error);
}