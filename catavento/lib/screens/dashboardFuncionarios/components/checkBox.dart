import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class CheckBox extends StatefulWidget {
  final TextEditingController controller;
  final String tipo;

  const CheckBox({super.key, required this.controller, required this.tipo});
  @override
  State<CheckBox> createState() {
    return CheckBoxState();
  }
}

class CheckBoxState extends State<CheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        checkboxTheme: CheckboxThemeData(
          side: BorderSide(color: AppColors.mediumPink),
        ),
      ),
      child: Checkbox(
        value: isChecked,
        onChanged: (bool? value) {
          widget.controller.text = widget.tipo;
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}
