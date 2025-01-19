import 'package:flutter/material.dart';

class ButtonCard extends StatefulWidget {
  final Widget title;
  final Icon icon;
  final bool isCompleted;

  final Function() onPressed;

  const ButtonCard(
      {super.key,
        required this.title,
        required this.icon,
        required this.onPressed,
        required this.isCompleted});

  @override
  State<ButtonCard> createState() => _ButtonCardState();
}

class _ButtonCardState extends State<ButtonCard> {
  @override


  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        widget.onPressed();

      },


      child: Container(
          height: 40,
          width: 220,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                widget.isCompleted ? Color(0xFF147349) : Color(0xFF025D99) ,
                widget.isCompleted ? Color(0xFF1FCD70) : Color(0xFF025D99),
              ]),
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
              child: widget.isCompleted
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Bolo Concluído", style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,

                  ),),
                  SizedBox(width: 10,),
                  Icon(Icons.check , color: Colors.white,)
                  
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [widget.title,
                  SizedBox(width: 10,),
                  widget.icon,
                ],
              ))),
    );
  }
}