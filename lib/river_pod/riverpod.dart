import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:places/model/place_model.dart';
import '../widgets/location_input.dart';

final placesAddProvider = StateNotifierProvider<PlacesNotifier, List<Places>>(
    (ref) => PlacesNotifier());

class PlacesNotifier extends StateNotifier<List<Places>> {
  PlacesNotifier() : super([]);

  void placesAdd(Places newItem) {
    state = [...state, newItem];
  }
}

class TextNotifier extends StateNotifier<String> {
  TextNotifier() : super('');

  void setText(text) {
    state = text;
  }
}

final textControllerProvider =
    StateNotifierProvider<TextNotifier, String?>(
  (ref) => TextNotifier(),
);

final weatherProvider = StateProvider<String>((ref) => weather);
final currentCityProvider = StateProvider<Map<String, dynamic>?>((ref) => data);
