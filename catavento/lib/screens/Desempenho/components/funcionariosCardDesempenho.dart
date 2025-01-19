import 'package:catavento/screens/Desempenho/components/bolosDesempenhoCard.dart';
import 'package:catavento/shared/theme/colors.dart';
import 'package:catavento/shared/widgets/dialog.dart';
import 'package:flutter/material.dart';

class FuncionariosCardDesempenho extends StatefulWidget {
  final String nomeFuncionario;
  final String setor;

  FuncionariosCardDesempenho({
    required this.nomeFuncionario,
    required this.setor,
  });

  @override
  State<FuncionariosCardDesempenho> createState() {
    return FuncionariosCardDesempenhoState();
  }
}

class FuncionariosCardDesempenhoState extends State<FuncionariosCardDesempenho> {
  //Dados temporarios
  final String nome = '{nomeFuncionario}';
  final String setor = '{setor}';
  final String mediaDesempenho = '00:00';

    final List<Map<String, String>> bolos = [
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
    {'nomeDemanda': '{nomeDemanda}', 'inicio': '10:50', 'fim' : '11:40', 'duracao' : '00:50', 'image' : '../catavento/assets/images/cake.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: AppColors.lightGray,
      child: Row(
        children: [
          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          Icon(
            Icons.person,
            color: AppColors.blue,
            size: 45,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.nomeFuncionario,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blue
                  ),
                ),
                Text(
                  'Setor: ${widget.setor}',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.blue
                  ),
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.info, color: AppColors.blue,),
            onPressed: () {
              _showInfoDialog(context, nome, setor, mediaDesempenho);
            },
          )
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String nome, String setor,
      String mediaDesempenho) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableDialog(
          backgroundColor: AppColors.lightGray,
          title: nome,
          body: SingleChildScrollView(
            // Adicionando SingleChildScrollView para evitar overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(16), // Bordas arredondadas
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, color: AppColors.blue,),
                          Text(
                            'Dados',
                            style: TextStyle(
                              color: AppColors.blue,
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.17,
                          width: MediaQuery.of(context).size.width * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: AppColors.lightGray
                          ),
                          child: Icon(Icons.person, color: AppColors.blue, size: 70,),
                        )
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                      Center(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Nome: ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  nome,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Row(
                              children: [
                                Text(
                                  'Setor: ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  setor,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _showDesempenhoDialog(context, nome, setor, mediaDesempenho);
                                  },
                                  child: Text(
                                  'Desempenho: ',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                ),

                                InkWell(
                                  onTap: () {
                                    _showDesempenhoDialog(context, nome, setor, mediaDesempenho);
                                  },
                                  child: Text(
                                  mediaDesempenho,
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: AppColors.blue,
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDesempenhoDialog(BuildContext context, String nome, String setor,
      String mediaDesempenho) {
    showDialog(
      context: context,
      builder: (context) {
        return ReusableDialog(
          backgroundColor: AppColors.lightGray,
          title: 'Desempenhos',
          body: SingleChildScrollView(
            // Adicionando SingleChildScrollView para evitar overflow
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.gradientDarkBlue),
                    borderRadius:
                        BorderRadius.circular(16), // Bordas arredondadas
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: bolos.length,
                      itemBuilder: (context, index) {
                        final bolo = bolos[index];
                        return Bolosdesempenhocard(
                          nomeDemanda: bolo['nomeDemanda']!,
                          inicio: bolo['inicio']!,
                          fim: bolo['fim']!,
                          duracao: bolo['duracao']!,
                          image: bolo['image']!,
                        );
                      }
                    ),
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}