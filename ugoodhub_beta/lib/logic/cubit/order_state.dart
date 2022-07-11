part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderDetail extends OrderState {
  final int quantity;
  final int price;

  OrderDetail({required this.quantity, required this.price});
}
