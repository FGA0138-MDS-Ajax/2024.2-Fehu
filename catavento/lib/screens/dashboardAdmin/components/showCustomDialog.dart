import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:catavento/screens/dashboardAdmin/components/stage_demand.dart';

class ShowCustomDialog extends StatelessWidget {
  final String name;
  final String code;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String description;

  // Construtor para receber os parâmetros
  const ShowCustomDialog({
    super.key,
    required this.name,
    required this.code,
    required this.createdAt,
    required this.updatedAt,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    String createdAtFormat = DateFormat('dd/MM/yyyy').format(createdAt);
    String updatedAtFormat = DateFormat('dd/MM/yyyy').format(updatedAt);

    // Retorna diretamente um Dialog
    return AlertDialog(
      backgroundColor: Color(0xFFD1EEFF),
      content: SizedBox(
        width: 560,
        child: Padding(
          padding: const EdgeInsets.only(top: 41),
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Nome da demanda $name",
                          style: TextStyle(
                            fontSize: 24,
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
                SizedBox(height: 31),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 186,
                      height: 202,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Código: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            children: [TextSpan(text: code)],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Data do pedido: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            children: [TextSpan(text: createdAtFormat)],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Prazo: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            children: [TextSpan(text: updatedAtFormat)],
                          ),
                        ),
                        SizedBox(height: 10),
                        RichText(
                          text: TextSpan(
                            text: "Descrição: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                            children: [TextSpan(text: description)],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  "Acompanhamento da produção",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  "Status: Em andamento",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 20),
                StageDemand(status: "finished"),
                SizedBox(height: 20),
                StageDemand(status: "InProgress"),
                SizedBox(height: 20),
                StageDemand(status: "Erro"),
              ],
            ),
          ),
        ),
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.0),
        borderSide: BorderSide.none,
      ),
    );
  }
}
