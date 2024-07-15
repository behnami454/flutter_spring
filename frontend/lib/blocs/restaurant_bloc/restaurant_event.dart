part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchRestaurants extends RestaurantEvent {}

class AddRestaurant extends RestaurantEvent {
  final Restaurant restaurant;

  const AddRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class UpdateRestaurant extends RestaurantEvent {
  final Restaurant restaurant;

  const UpdateRestaurant(this.restaurant);

  @override
  List<Object> get props => [restaurant];
}

class DeleteRestaurant extends RestaurantEvent {
  final int id;

  const DeleteRestaurant(this.id);

  @override
  List<Object> get props => [id];
}