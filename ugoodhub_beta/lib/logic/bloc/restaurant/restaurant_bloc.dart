import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../model/restaurant.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(RestaurantInitial(location: "Kampus D")) {
    on<LoadRestaurant>(_onLoadRestaurant);
  }
  void _onLoadRestaurant(
      LoadRestaurant event, Emitter<RestaurantState> emit) async {
    List<Restaurant> restaurantList;
    if (state is RestaurantInitial) {
      String location = (state as RestaurantInitial).location;
      restaurantList = await Restaurant.connectToAPI(location, 1, 6);
      emit((restaurantList.isEmpty)
          ? RestaurantLoaded(
              hasReachedMax: true,
              restaurantList: restaurantList,
              location: location)
          : RestaurantLoaded(
              page: 1,
              hasReachedMax: false,
              restaurantList: restaurantList,
              location: location));
    } else {
      RestaurantLoaded restaurantLoaded = state as RestaurantLoaded;
      if (event.location == null) {
        restaurantList = await Restaurant.connectToAPI(
            restaurantLoaded.location, (restaurantLoaded.page)! + 1, 6);
        emit((restaurantList.isEmpty)
            ? restaurantLoaded.copyWith(
                hasReachedMax: true,
              )
            : restaurantLoaded.copyWith(
                restaurantList:
                    restaurantLoaded.restaurantList + restaurantList,
                hasReachedMax: false,
                page: restaurantLoaded.page! + 1,
              ));
      } else {
        restaurantList = await Restaurant.connectToAPI(event.location!, 1, 6);
        emit((restaurantList.isEmpty)
            ? RestaurantLoaded(
                hasReachedMax: true,
                restaurantList: restaurantList,
                location: event.location!)
            : RestaurantLoaded(
                page: 1,
                hasReachedMax: false,
                restaurantList: restaurantList,
                location: event.location!));
      }
    }
  }
}
