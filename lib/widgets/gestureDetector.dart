import 'package:flutter/material.dart';

class PhotoGesture extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const PhotoGesture({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 260,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
        decoration: BoxDecoration(
            color: Colors.deepOrange[400],
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
