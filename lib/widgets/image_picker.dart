import 'dart:io';

import 'package:flutter/material.dart';


class ImageTaker extends StatefulWidget {
  const ImageTaker({super.key, required this.resImage, this.reTakeImage});

  final File? resImage;
  final Function? reTakeImage;

  @override
  State<ImageTaker> createState() => _ImageTakerState();
}

class _ImageTakerState extends State<ImageTaker> {
  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: () => widget.reTakeImage!(),
        icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
    );

    if (widget.resImage != null) {
      content = Image.file(
        fit: BoxFit.fitWidth,
        widget.resImage!,
        width: double.infinity,
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => widget.reTakeImage!(),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            border: Border.all(style: BorderStyle.solid, width: 2),
          ),
          child: content,
        ),
      ),
    );
  }
}
