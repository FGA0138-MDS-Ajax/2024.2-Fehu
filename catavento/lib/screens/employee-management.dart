import 'package:flutter/material.dart';
import 'components/background.dart';
import 'components/header.dart';
import 'components/blocks.dart';
import 'components/showDialog.dart';
import 'package:catavento/screens/components/menu.dart';

class EmployeeManagement extends StatelessWidget {
  const EmployeeManagement({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF015C98),
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 20), // Padding aqui
              child: Material(
                color: Colors.transparent, // Mantém o fundo transparente
                child: InkWell(
                  onTap: () {
                    Scaffold.of(context).openDrawer(); // Abre o Drawer
                  },
                ),
              ),
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 20), // Ajuste o valor conforme necessário
            child: TextButton.icon(
              icon: const Icon(Icons.history, size: 18.0),
              label: const Text("Ver Histórico"),
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF015C98),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundPage(
        gradientColors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)],
        children: [
          Header(title: "Funcionários"),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Blocks(
                    color: Colors.white,
                    height: 97,
                    width: 321,
                    borderRadius: 26,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.group,
                            size: 30,
                            color: Color(0xFF015C98),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.height * 0.04),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  /*Blocks(
                    color: Colors.white,
                    height: 97,
                    width: 321,
                    borderRadius: 26,
                    children: [
                    
                    ],
                  ),*/

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        //Logica do botão
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Showdialog(
                              width: 463,
                              height: 402,
                              title: 'Novo funcionário',
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF015C98),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26)),
                      ),
                      child: Text(
                        "Cadastrar funcionário",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.height * 0.07),

              /*Blocks(
                color: Colors.white,
                height: 559,
                width: 346,
                borderRadius: 26,
                children: []
                ),

              SizedBox(width: MediaQuery.of(context).size.height * 0.07),

              Blocks(
                color: Colors.white,
                height: 559,
                width: 380,
                borderRadius: 26,
                children: []
                )*/
            ],
          ),
        ],
      ),
    );
  }
}
