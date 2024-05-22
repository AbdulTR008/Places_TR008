import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../river_pod/riverpod.dart';
import '../screens/places_detailed_screen.dart';
import 'package:places/model/place_model.dart';

class PlacesList extends ConsumerStatefulWidget {
  
  @override
  ConsumerState<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends ConsumerState<PlacesList> {
  @override
  Widget build(BuildContext context) {
    List<Places> myPlacesList = ref.watch(placesAddProvider);
    if (myPlacesList.isEmpty) {
      return const Center(
        child: Text(
          'No Places Added',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return ListView.builder(
      itemCount: myPlacesList.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailedScreen(index: index),
            ),
          ),
          trailing: CircleAvatar(
            backgroundImage: FileImage(myPlacesList[index].images),
          ),
          title: Text(
            myPlacesList[index].title,
            style: const TextStyle(color: Colors.red),
          ),
          subtitle: Text(myPlacesList[index].weather),
        );
      },
    );
  }
}
