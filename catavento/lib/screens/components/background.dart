import 'package:flutter/material.dart';

class BackgroundPage extends StatelessWidget {
  final Color? backgroundColor;
  final List<Color>? gradientColors;
  final List<Widget>children;

  BackgroundPage({
    this.backgroundColor,
    this.gradientColors,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Cor de fundo
        Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              gradient: gradientColors != null
                ? LinearGradient(
                colors: gradientColors!,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
              : null,
            ),
          ),

          //Conteúdo
          Column(
            children: children,
          )
      ],
    );
  }
}
