import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:qrmenu/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:qrmenu/models/restaurant_model/restaurant_model.dart';

import 'package:qrmenu/screens/resuarant_screens/resaurant_map_screen.dart';

class AddRestaurantScreen extends StatefulWidget {
  const AddRestaurantScreen({Key? key}) : super(key: key);

  @override
  State<AddRestaurantScreen> createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _googleMapsLinkController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _emailController.dispose();
    _googleMapsLinkController.dispose();
    super.dispose();
  }

  Future<void> _openMap() async {
    final selectedLocation = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MapScreen(),
      ),
    );

    if (selectedLocation != null) {
      setState(() {
        _googleMapsLinkController.text = '${selectedLocation.latitude},${selectedLocation.longitude}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _googleMapsLinkController,
                  decoration: const InputDecoration(labelText: 'Google Maps Link'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _openMap,
                  child: const Text('Select Location on Map'),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final newRestaurant = Restaurant(
                        id: 0,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        googleMapsLink: _googleMapsLinkController.text,
                      );
                      context.read<RestaurantBloc>().add(AddRestaurant(newRestaurant));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Add Restaurant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
