import 'package:flutter/material.dart';

class Blocks extends StatefulWidget {
  final String? title;
  final Color? titleColor;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color color;
  final Widget child;

  Blocks({
    this.title,
    this.titleColor,
    this.height,
    this.width,
    this.borderRadius = 16.0,
    required this.color,
    required this.child,
  });

  @override
  State<Blocks> createState() {
    return BlocksState();
  }
}

class BlocksState extends State<Blocks> {
  @override
  Widget build(BuildContext context) {
    final double defaultHeight = MediaQuery.of(context).size.height * 0.75;
    final double defaultWidth = MediaQuery.of(context).size.width * 0.3;

    return Stack(
      children: [
        Container(
          height: widget.height ?? defaultHeight,
          width: widget.width ?? defaultWidth,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.circular(widget.borderRadius)),
        ),
        if (widget.title != null)
          Positioned(
            top: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                widget.title!,
                style: TextStyle(
                    fontSize: 16,
                    color: widget.titleColor,
                    fontFamily: 'FredokaOne'),
              ),
            ),
          ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
