import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class Widgetdesempenho extends StatelessWidget {

  final String data;
  final double isCompleted , isMissing , goal;
  const Widgetdesempenho({super.key , required this.data , required this.isMissing, required this.isCompleted , required this.goal});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFEBEBEB), borderRadius: BorderRadius.circular(12)),
      height: 208,
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
                      Icon(Icons.cake, color: Color(0xFF015C98)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Meu Desempenho ${data}",
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
                    height: 100,
                    width: 500,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                        padding: EdgeInsets.only(top:10 , right: 40, left: 40, bottom: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Meta ${goal}",
                                  style: TextStyle(
                                      color: Color(0xFF015C98),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Color(0xFF1FCD70),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Concluídas: ${isCompleted}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFED5EA3),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "Faltam: ${isMissing}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )))
              ],
            ),
          )
        ],
      ),
    );
  }
}
