import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class CheckBox extends StatefulWidget {

  @override
  State<CheckBox> createState() {
    return CheckBoxState();
  }
}

class CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context){
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: AppColors.mediumPink),
        ),
      ),
      child: Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    ),
  );
  }  
}