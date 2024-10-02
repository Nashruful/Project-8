part of 'order_state_bloc.dart';

sealed class OrderStateEvent {}


final class StartTimerEvent extends OrderStateEvent {}

final class RunTimerEvent extends OrderStateEvent {}
final class StopTimerEvent extends OrderStateEvent {}

//اضافتي 

class FetchOrdersEvent extends OrderStateEvent {}
