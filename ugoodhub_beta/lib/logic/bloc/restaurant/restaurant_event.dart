part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantEvent {}

class LoadRestaurant extends RestaurantEvent {
  final String? location;

  LoadRestaurant({this.location});
}
