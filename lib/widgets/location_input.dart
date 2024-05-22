import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';

import '../river_pod/riverpod.dart';

class NetworkInput extends ConsumerStatefulWidget {
  const NetworkInput({
    super.key,
  });

  @override
  ConsumerState<NetworkInput> createState() => _NetworkInputState();
}

String weather = '';
Map<String, dynamic>? data;

class _NetworkInputState extends ConsumerState<NetworkInput> {
  bool isLoading = false;

  Future<void> fetchWeather() async {
    // final progress = ProgressHUD.of(context);
    setState(() {
      isLoading = true;
      // progress?.showWithText('Loading Please Wair');
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=${ref.watch(textControllerProvider)}&appid=51e2bfc9ac9c2823f29e6cef332bb5f1'),
      );
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        print(' _NetworkInputState  ${data}');
        setState(() {
          weather = data!['weather'][0]['main'];

          isLoading = false;

          // progress?.dismiss();
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            content: const Text('Text Cannot Empty'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              height: 50,
              width: 200,
              child: Center(
                  child: Text(
                "Weather : $weather ",
                style: const TextStyle(fontSize: 15),
              )),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () => fetchWeather(),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(' Current Weather'),
            ),
          ],
        ),
      ),
    );
  }
}



// void _getLocation() async {
//   final isServiceEnable = await Geolocator.isLocationServiceEnabled();

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

//     Position position = await Geolocator.getCurrentPosition();
//   } catch (details) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(details.toString()),
//         ),
//       );
//     }
//   }
// }


// Future<void> fetchWeather() async {
//   final progress = ProgressHUD.of(context);
//   setState(() {
//     isLoading = true;
//     progress?.showWithText('Loading Please Wair');
//   });

//   try {
//     final response = await http.get(Uri.parse(
//         'https://api.openweathermap.org/data/2.5/weather?q=${ref.watch(textControllerProvider)}&appid=51e2bfc9ac9c2823f29e6cef332bb5f1'));
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         weather = data['weather'][0]['main'];
//         isLoading = false;
//         progress?.dismiss();
//       });
//     }
//   } catch (e) {
//     print(e);
//   }
// }


  // ElevatedButton(
  //               onPressed: () => fetchWeather(),
  //               child: isLoading
  //                   ? const CircularProgressIndicator()
  //                   : const Text('Map'),
  //             ),