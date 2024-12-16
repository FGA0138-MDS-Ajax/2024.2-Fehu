import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(
              'João das Couves', // depois alterar aqui pra pegar o nome no banco de dados
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            accountEmail: const Text(
              'Administrador', // depois alterar aqui pra pegar o setor no banco de dados
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: Color(0xFFF4D5D7),
            ),
          ),
          ListTile(
            title: const Text('Demandas'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/home/');
            },
          ),
          ListTile(
            title: const Text('Funcionários'),
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, '/dashboard-admin-crud-funcionarios');
            },
          ),
          ListTile(
            title: const Text('Produtos'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Sair da Conta'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
