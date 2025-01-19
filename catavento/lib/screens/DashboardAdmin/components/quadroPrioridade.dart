import 'package:flutter/material.dart';

class QuadroPrioridade extends StatefulWidget {
  const QuadroPrioridade({super.key});

  @override
  State<QuadroPrioridade> createState() {
    return QuadroPrioridadeState();
  }
}

class QuadroPrioridadeState extends State<QuadroPrioridade> {
  Color colorQ = Color(0xFFC3206F);

  //Troca a cor do quadro
  void prioridadeAlta() {
    setState(() {
      colorQ = Color(0xFFC3206F);
    });
  }

  //Troca a cor do quadro
  void prioridadeMedia() {
    setState(() {
      colorQ = Color(0xFFFF66B0);
    });
  }

  //Troca a cor do quadro
  void prioridadeBaixa() {
    setState(() {
      colorQ = Color(0xFFFFC6E1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Quadro de prioridade
        Container(
          width: 340,
          height: 398,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: colorQ),
        ),

        SizedBox(
          height: 15,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Botão alta prioridade
            Expanded(
              // width: 97,
              // height: 24,
              child: ElevatedButton(
                onPressed: prioridadeAlta,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC3206F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Alta',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),

            //Botão média prioridade
            Expanded(
              // width: 97,
              // height: 24,
              child: ElevatedButton(
                onPressed: prioridadeMedia,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF66B0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Média',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            SizedBox(
              width: 10,
            ),

            //Botão baixa prioridade
            Expanded(
              // width: 97,
              // height: 24,
              child: ElevatedButton(
                onPressed: prioridadeBaixa,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFC6E1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  'Baixa',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}