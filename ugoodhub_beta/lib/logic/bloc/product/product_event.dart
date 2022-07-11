part of 'product_bloc.dart';

@immutable
abstract class ProductEvent {}

class LoadProduct extends ProductEvent {
  final String? restaurantId;
  LoadProduct({this.restaurantId});
}
