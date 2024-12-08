import 'package:flutter/material.dart';

class IconMenu extends StatefulWidget {
  const IconMenu({super.key});

  @override
  State<IconMenu> createState() {
    return IconMenuState();
  }
}

class IconMenuState extends State<IconMenu> {
  void openMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.pink[100],
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 25,
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'João das Couves',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Administrador',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text('Demandas'),
                onTap: () {
                  // Ação para Demandas
                },
              ),
              ListTile(
                title: Text('Funcionários'),
                onTap: () {
                  // Ação para Funcionários
                },
              ),
              ListTile(
                title: Text('Produtos'),
                onTap: () {
                  // Ação para Produtos
                },
              ),
              ListTile(
                title: Text('Sair da Conta'),
                onTap: () {
                  // Ação para Sair da Conta
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: 35,
      onPressed: () => openMenu(context),
      icon: Icon(Icons.menu),
      color: Color(0xFF015C98),
    );
  }
}
