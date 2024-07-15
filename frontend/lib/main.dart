import 'package:flutter/material.dart';

import 'package:qrmenu/configs/bloc_providers/bloc_providers.dart';
import 'package:qrmenu/configs/shared_prefrences/shared_prefrences.dart';
import 'package:qrmenu/screens/entrance_screens/login_screen.dart';
import 'package:qrmenu/screens/entrance_screens/register_screen.dart';
import 'package:qrmenu/screens/home_screen.dart';

import 'package:qrmenu/screens/resuarant_screens/add_resaurant_screen.dart';
import 'package:qrmenu/screens/resuarant_screens/edit_resaurant_screen.dart';

import 'models/restaurant_model/restaurant_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedUser = await SharedPreferencesService.getUser();
  runApp(MyApp(isUserLoggedIn: savedUser != null));
}

class MyApp extends StatelessWidget {
  final bool isUserLoggedIn;

  const MyApp({Key? key, required this.isUserLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProviders(
      child: MaterialApp(
        title: 'QR Menu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: isUserLoggedIn ? '/' : '/login',
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/addRestaurant': (context) => const AddRestaurantScreen(),
          '/editRestaurant': (context) => EditRestaurantScreen(
            restaurant: ModalRoute.of(context)!.settings.arguments as Restaurant,
          ),
        },
      ),
    );
  }
}