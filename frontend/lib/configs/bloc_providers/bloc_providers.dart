import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrmenu/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:qrmenu/blocs/user_bloc/user_bloc.dart';

import 'package:qrmenu/repositories/restaurant_repository/restaurant_repository.dart';

import 'package:qrmenu/repositories/user_repository/user_repository.dart';
import 'package:qrmenu/services/api_service.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;

  const BlocProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final restaurantRepository = RestaurantRepository(apiService: apiService);
    final userRepository = UserRepository(apiService: apiService);

    return MultiBlocProvider(
      providers: [
        BlocProvider<RestaurantBloc>(
          create: (context) => RestaurantBloc(restaurantRepository: restaurantRepository),
        ),
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(userRepository: userRepository),
        ),
      ],
      child: child,
    );
  }
}
