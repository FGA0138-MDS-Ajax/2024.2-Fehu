import 'dart:ffi';

import 'package:flutter/material.dart';
import 'components/background.dart';
import 'components/header.dart';
import 'components/blocks.dart';

class EmployeeManagement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundPage(
        gradientColors: [Color(0xFF75CDF3), Color(0xFFB2E8FF)] ,
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
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  Blocks(
                    color: Colors.white,
                    height: 97,
                    width: 321,
                    borderRadius: 26,
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ElevatedButton(
                      onPressed: () {
                        //Logica do botão
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF015C98),
                        padding: EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26)
                        )
                      ),
                      child: Text(
                        "Cadastrar funcionário",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                        ),
                        )
                      ), 
                  )
                ],
              ),

              SizedBox(width: MediaQuery.of(context).size.height * 0.07),


              Blocks(
                color: Colors.white,
                height: 559,
                width: 346,
                borderRadius: 26,
                ),

              SizedBox(width: MediaQuery.of(context).size.height * 0.07),

              Blocks(
                color: Colors.white,
                height: 559,
                width: 380,
                borderRadius: 26,
                )

            ],
          )
        ]
      ),
    );
  }
}