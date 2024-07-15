import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrmenu/models/restaurant_model/restaurant_model.dart';
import 'package:qrmenu/repositories/restaurant_repository/restaurant_repository.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository restaurantRepository;

  RestaurantBloc({required this.restaurantRepository}) : super(RestaurantInitial()) {
    on<FetchRestaurants>(_onFetchRestaurants);
    on<AddRestaurant>(_onAddRestaurant);
    on<UpdateRestaurant>(_onUpdateRestaurant);
    on<DeleteRestaurant>(_onDeleteRestaurant);
  }

  void _onFetchRestaurants(FetchRestaurants event, Emitter<RestaurantState> emit) async {
    emit(RestaurantLoading());
    try {
      final restaurants = await restaurantRepository.fetchRestaurants();
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  void _onAddRestaurant(AddRestaurant event, Emitter<RestaurantState> emit) async {
    try {
      await restaurantRepository.createRestaurant(event.restaurant);
      emit(RestaurantAdded());
      add(FetchRestaurants());
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  void _onUpdateRestaurant(UpdateRestaurant event, Emitter<RestaurantState> emit) async {
    try {
      await restaurantRepository.updateRestaurant(event.restaurant);
      add(FetchRestaurants());
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }

  void _onDeleteRestaurant(DeleteRestaurant event, Emitter<RestaurantState> emit) async {
    try {
      await restaurantRepository.deleteRestaurant(event.id);
      add(FetchRestaurants());
    } catch (e) {
      emit(RestaurantError(e.toString()));
    }
  }
}