import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrmenu/blocs/restaurant_bloc/restaurant_bloc.dart';
import 'package:qrmenu/models/restaurant_model/restaurant_model.dart';
import 'package:qrmenu/screens/resuarant_screens/resaurant_map_screen.dart';

class EditRestaurantScreen extends StatefulWidget {
  final Restaurant restaurant;

  const EditRestaurantScreen({Key? key, required this.restaurant}) : super(key: key);

  @override
  _EditRestaurantScreenState createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _googleMapsLinkController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.restaurant.name);
    _descriptionController = TextEditingController(text: widget.restaurant.description);
    _googleMapsLinkController = TextEditingController(text: widget.restaurant.googleMapsLink);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
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
        title: const Text('Edit Restaurant'),
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final updatedRestaurant = Restaurant(
                        id: widget.restaurant.id,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        googleMapsLink: _googleMapsLinkController.text,
                      );
                      context.read<RestaurantBloc>().add(UpdateRestaurant(updatedRestaurant));
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Changes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<RestaurantBloc>().add(DeleteRestaurant(widget.restaurant.id));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text(
                    'Delete Restaurant',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
