import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class WidgetDadosFuncionario extends StatelessWidget {
  final String nome;
  final String nickname;
  final String email;
  final String setor;

  const WidgetDadosFuncionario({
    super.key,
    required this.nome,
    required this.nickname,
    required this.email,
    required this.setor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFEBEBEB), borderRadius: BorderRadius.circular(12)),
      height: 290,
      width: 530,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person_outline, color: Color(0xFF015C98)),
                      Text(
                        "Meus Dados",
                        style: TextStyle(
                            color: Color(0xFF015C98),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 180,
                    width: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Nome: ",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                "${nome}",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              Text(
                                "Nome de Usuário: ",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                "${nickname}",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),

                          Row(
                            children: [
                              Text(
                                "Email: ",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                "${email}",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),

                          Row(
                            children: [
                              Text(
                                "Setor: ",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              Text(
                                "${setor} ",
                                style: TextStyle(
                                    color: Color(0xFF015C98),
                                    fontSize: 16),
                              ),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
