import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final bool showHistoricoButton;

  const Header(
      {super.key, required this.title, this.showHistoricoButton = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconMenu(),
              if (showHistoricoButton) // o header mostra o botão somente se showHistoricoButton for true
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF015C98),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text('Ver histórico',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF015C98),
            ),
          ),
        ],
      ),
    );
  }
}

// Icon Menu
class IconMenu extends StatefulWidget {
  const IconMenu({super.key});

  @override
  State<IconMenu> createState() {
    return IconMenuState();
  }
}

class IconMenuState extends State<IconMenu> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 35,
      onPressed: () {
        // Lógica do menu
      },
      icon: Icon(Icons.menu),
      color: Color(0xFF015C98),
    );
  }
}
