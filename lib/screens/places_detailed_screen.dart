import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


import '../river_pod/riverpod.dart';



class DetailedScreen extends ConsumerStatefulWidget {
  const DetailedScreen({super.key, required this.index});

  final int index;

  @override
  ConsumerState<DetailedScreen> createState() => _DetailedScreen();
}

class _DetailedScreen extends ConsumerState<DetailedScreen> {
  @override
  Widget build(BuildContext context) {
    final title = ref.watch(placesAddProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detailed Screen'),
      ),
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  title[widget.index].title,
                  textStyle: const TextStyle(fontSize: 40, color: Colors.amber),
                ),
              ],
              isRepeatingAnimation: true,
            ),
          ],
        ),
      ),
    );
  }
}




  // final imagePicker = ImagePicker();
  // var pickedImage;
  // File? selectedImage;
  // _saveImages() async {
  //   pickedImage = await imagePicker.pickImage(
  //       source: ImageSource.camera, maxHeight: 600, maxWidth: double.infinity);
  //   if (pickedImage == null) {
  //     return;
  //   }

  //   setState(() {
  //     selectedImage = File(pickedImage.path);
  //   });
  // }