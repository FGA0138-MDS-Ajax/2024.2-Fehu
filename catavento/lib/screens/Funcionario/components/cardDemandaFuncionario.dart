import 'package:catavento/screens/Funcionario/components/buttonCard.dart';
import 'package:flutter/material.dart';

class CardDemanda extends StatelessWidget {
  final String title , description ;
  final String codigo;
  const CardDemanda({super.key , required this.title , required this.description , required this.codigo});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height / 1.2;
    double screenHeightCard = MediaQuery.of(context).size.height / 2.2;

    return Container(
      width: 300,
      height: screenHeight,
      constraints: BoxConstraints(
        maxHeight: 679,
      ),
      decoration: BoxDecoration(
          color: Color(0xFFEBEBEB), borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.only(top: 20, left: 7.5, right: 7.5, bottom: 0),
        child: Column(
          children: [
            Text(
              "${title}",
              style: TextStyle(
                  color: Color(0xFF015C98),
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(height: 10),
            Container(

              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: Offset(3, 3),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ]),
              height: 150,
            ),
            SizedBox(height: 10),
            Container(
              height: screenHeightCard,
              constraints: BoxConstraints(
                maxHeight: 384,
              ),

              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding:
                EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Color(0xFF015C98),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Informações",
                          style: TextStyle(
                              color: Color(0xFF015C98),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "Código: ",
                          style: TextStyle(
                              color: Color(0xFF015C98),
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${codigo}",
                          style:
                          TextStyle(color: Color(0xFF015C98), fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Descrição: ",
                      style: TextStyle(
                          color: Color(0xFF015C98),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 10,
                        "${description}",
                        style: TextStyle(
                            color: Color(0xFF015C98), fontSize: 14),
                      ),
                    ),
                  ],

                ),
              ),
            ),
            SizedBox(height: 12,),
            ButtonCard(title: Text("Inicar Bolo" , style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),), icon: Icon(Icons.alarm , color: Colors.white,), onPressed: ()=> {}, isCompleted: true),

          ],
        ),
      ),
    );
  }
}
