import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/location_input.dart';
import '../river_pod/riverpod.dart';
import '../model/place_model.dart';
import '../widgets/image_picker.dart';
import '../widgets/map.dart';

class AddPlacesScreen extends ConsumerStatefulWidget {
  const AddPlacesScreen({super.key});

  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  final titleController = TextEditingController();


  String? _enteredText;

  @override
  void dispose() {
    super.dispose();
    
    titleController.removeListener(() {});
  }

  dynamic places() {
    _enteredText = titleController.text;
    final weatherData = ref.read(weatherProvider);

    if (_enteredText == null || _enteredText!.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
          content: const Text('Text Cannot Empty'),
        ),
      );
    }

    ref.read(placesAddProvider.notifier).placesAdd(Places(
        images: selectedImage!,
        title: titleController.text,
        weather: weatherData));
    Navigator.pop(context);
  }

  final imagePicker = ImagePicker();
  XFile? pickedImage;
  File? selectedImage;

  void _saveImages() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, maxHeight: 600, maxWidth: double.infinity);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      selectedImage = File(pickedImage!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
   
    titleController.addListener(() => ref
        .watch(textControllerProvider.notifier)
        .setText(titleController.text));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Place'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  style: const TextStyle(color: Colors.red),
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(),
                  controller: titleController,
                ),
                const SizedBox(
                  height: 20,
                ),
                ImageTaker(
                  reTakeImage: () {
                    _saveImages();
                  },
                  resImage: selectedImage,
                ),
                const NetworkInput(),
                const SizedBox(
                  height: 10,
                ),
                const Map(),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: places,
                  child: const Text('Add Place'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
