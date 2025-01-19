import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class Inputs extends StatefulWidget {
  final String text;
  final String? hint;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  Inputs({
    required this.text,
    this.hint,
    this.controller,
    this.onChanged,
  });

  @override
  State<Inputs> createState() {
    return InputsState();
  }
}

class InputsState extends State<Inputs>{
  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.3,
      child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 15,
            color: AppColors.blue,
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(width: 4,),

        Expanded(
          child: SizedBox(
            height: 33,
            child: TextField(
              controller: widget.controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.grey
                ),
                hintText: widget.hint?? '',
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mediumPink) ,
                  borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.mediumPink) ,
                  borderRadius: BorderRadius.circular(15)
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)
              ),
          ),
          )
          
        ),
      ],
    ),
    );
    
  }
}