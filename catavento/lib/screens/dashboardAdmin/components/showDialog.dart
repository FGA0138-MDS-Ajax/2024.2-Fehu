import 'package:flutter/material.dart';

class Showdialog extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final List<Widget>? children;

  Showdialog({
    this.height,
    this.width,
    required this.title,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double blockWidth = width ?? screenWidth * 0.9;
    double blockHeight = height ?? screenHeight * 0.5;

    return Stack(
      children: [
        AlertDialog(
          backgroundColor: Color(0xFFD1EEFF),
          content: SizedBox(
            width: blockWidth,
            height: blockHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Título e botão de fechar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                ...?children,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
