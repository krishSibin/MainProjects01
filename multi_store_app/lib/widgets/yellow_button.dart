import 'package:flutter/material.dart';

class YellowButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double width;

  const YellowButton(
      {super.key,
      required this.label,
      required this.width,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: MediaQuery.of(context).size.width * width,
      decoration: BoxDecoration(
          color: Colors.yellow, borderRadius: BorderRadius.circular(25)),
      child: MaterialButton(
        onPressed: onPressed,
        child: Center(child: Text(label)),
      ),
    );
  }
}
