import 'package:flutter/material.dart';
import 'package:catavento/shared/theme/colors.dart';

class Filtrosetor extends StatefulWidget {
  final TextEditingController controller;

  const Filtrosetor({super.key, required this.controller});
  @override
  State<Filtrosetor> createState() {
    return FiltrosetorState();
  }
}

class FiltrosetorState extends State<Filtrosetor> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.04,
        width: MediaQuery.of(context).size.width * 0.13,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(8)),
        child: DropdownButton(
          isExpanded: true,
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.blue,
          ),
          hint: Text(
            'Filtro por setor',
            style: TextStyle(color: AppColors.blue, fontSize: 12),
          ),
          underline: SizedBox(),
          style: TextStyle(color: AppColors.blue, fontSize: 13),
          value: selectedOption,
          items: <String>['Cobertura', 'Aplique', 'Montagem', 'Todos']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: AppColors.blue),
              ),
            ); 
          }).toList(),
          onChanged: (newValue) {
            widget.controller.text = newValue!;
            setState(() {
              selectedOption = newValue;
            });
          }
        )
      );
  }
}