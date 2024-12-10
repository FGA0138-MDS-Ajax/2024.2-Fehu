import 'package:flutter/material.dart';

class Blocks extends StatefulWidget {
  final double? height;
  final double? width;
  final double borderRadius;
  final Color color;
  final String? title;

  Blocks({
    this.height,
    this.width,
    this.borderRadius = 16.0,
    required this.color,
    this.title,
  });

  @override
  State<Blocks> createState() {
    return BlocksState();
  }
}

class BlocksState extends State<Blocks> {

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double blockWidth = widget.width ?? screenWidth * 0.9;
    double blockHeight = widget.height ?? screenHeight * 0.5;

    return Container(
      width: blockWidth,
      height: blockHeight,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(widget.borderRadius)
      ),
    );

  }


}