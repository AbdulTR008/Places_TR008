
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../river_pod/riverpod.dart';

class Map extends ConsumerStatefulWidget {
  const Map({super.key});

  @override
  ConsumerState<Map> createState() => _MapState();
}

class _MapState extends ConsumerState<Map> {
  bool isMapActive = true;
  bool isLoading = false;

  double myLat = 0;
  double myLong = 0;

  void getLocation() async {
    final resJsonData = ref.watch(currentCityProvider);
    setState(() {
      isLoading = true;
    });
    setState(
      () {
        isMapActive = false;
        isLoading = false;
        myLong = resJsonData!['coord']['lon'] ?? 0;
        myLat = resJsonData['coord']['lat'] ?? 0;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blueAccent,
          height: 200,
          width: 200,
          child: isMapActive
              ? const Center(
                  child: Icon(FontAwesomeIcons.mapLocation),
                )
              : FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(myLat, myLong),
                    initialZoom: 9.2,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                  ],
                ),
        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: getLocation,
          child: isLoading
              ? const CircularProgressIndicator()
              : const Text('Get Location'),
        ),
      ],
    );
  }
}




  //  final isServiceEnable = await Geolocator.isLocationServiceEnabled();

  //   try {
  //     if (!isServiceEnable) {
  //       return Future.error("Sevice Not Enabled");
  //     }
  //     LocationPermission permission = await Geolocator.checkPermission();

  //     if (permission == LocationPermission.denied) {
  //       Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         return Future.error('Permission Denied');
  //       }
  //     }
  //     if (permission == LocationPermission.deniedForever) {
  //       return Future.error('Permission Denied Forever');
  //     }
  //       } catch (details) {
    // Position position = await Geolocator.getCurrentPosition();
  //     if (mounted) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(details.toString()),
  //         ),
  //       );
  //     }
  //   }