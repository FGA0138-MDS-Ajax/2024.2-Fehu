import 'package:catavento/shared/theme/colors.dart';
import 'package:flutter/material.dart';

class SearchFuncionarios extends StatefulWidget {
  const SearchFuncionarios({super.key});

  @override
  State<SearchFuncionarios> createState() {
    return SearchFuncionariosState();
  }
}

class SearchFuncionariosState extends State<SearchFuncionarios> {
  final TextEditingController _nomeProduto = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 32,
      child: TextField(
        controller: _nomeProduto,
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xFF015C98),
            ),
            //Icon de pesquisa

            hintText: "Insira o nome do funcionário para iniciar uma busca",
            hintStyle: TextStyle(
                fontSize: 11,
                color: AppColors.blue.withOpacity(0.5) //Opacidade do texto
                ),
            filled: true,
            fillColor: AppColors.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
              borderRadius: BorderRadius.circular(10),
            )
          ),
      ),
    );
  }
}