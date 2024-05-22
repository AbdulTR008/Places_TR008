import 'package:flutter/material.dart';

import 'package:places/screens/add_places_screen.dart';
import 'package:places/widgets/places_list.dart';
import '../widgets/map.dart';


class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  late Animation controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.scrim,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddPlacesScreen(),
                    ),
                  );
              },
              icon: const Icon(Icons.add),
              ),
            ],
          title: const Text(
            'Places',
            style: TextStyle(fontSize: 40),
          )
            
        ),
        backgroundColor: Theme.of(context).colorScheme.scrim,
        body: PlacesList());
  }
}
