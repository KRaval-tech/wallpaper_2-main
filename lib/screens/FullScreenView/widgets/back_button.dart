// Separate Widget for Back Button
import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 70.0, left: 20.0),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
