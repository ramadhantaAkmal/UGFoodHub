import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ug_foodhub/model/product.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  void loadOrder(Product product) {
    emit(OrderDetail(quantity: 1, price: product.price));
  }

  void increment(Product product) {
    int quantity = (state as OrderDetail).quantity + 1;
    emit(OrderDetail(quantity: quantity, price: quantity * product.price));
  }

  void decrement(Product product) {
    int quantity = (state as OrderDetail).quantity - 1;
    if (quantity < 1) quantity = 1;
    emit(OrderDetail(quantity: quantity, price: quantity * product.price));
  }
}
