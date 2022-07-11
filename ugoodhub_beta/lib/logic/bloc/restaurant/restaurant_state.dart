part of 'restaurant_bloc.dart';

@immutable
abstract class RestaurantState {}

class RestaurantInitial extends RestaurantState {
  final String location;

  RestaurantInitial({required this.location});
}

class RestaurantLoaded extends RestaurantState {
  final int? page;
  final List<Restaurant> restaurantList;
  final bool hasReachedMax;
  final String location;

  RestaurantLoaded(
      {this.page,
      required this.restaurantList,
      required this.hasReachedMax,
      required this.location});

  RestaurantLoaded copyWith(
      {int? page,
      List<Restaurant>? restaurantList,
      bool? hasReachedMax,
      String? location}) {
    return RestaurantLoaded(
        page: page ?? this.page,
        restaurantList: restaurantList ?? this.restaurantList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        location: location ?? this.location);
  }
}
