import 'package:catavento/shared/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:catavento/bloc/demanda/demanda_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() {
    return SearchState();
  }
}

class SearchState extends State<Search> {
  final TextEditingController _nomeDemanda = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.5,
      height: size.height * 0.04,
      child: TextField(
        controller: _nomeDemanda,
        cursorHeight: size.height * 0.014,
        style: TextStyle(fontFamily: "FredokaOne", fontSize: size.height * 0.014),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              size: size.width * 0.018,
              color: Color(0xFF015C98),
            ),
            //Icon de pesquisa

            hintText: "Insira o nome de uma demanda para iniciar uma busca",
            hintStyle: TextStyle(
                fontSize: size.height * 0.014,
                color: Colors.black.withOpacity(0.5) //Opacidade do texto
                ),
            filled: true,
            fillColor: AppColors.lightGray,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(size.height * 0.016),
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
              borderRadius: BorderRadius.circular(size.height * 0.016),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.lightGray, width: 2),
              borderRadius: BorderRadius.circular(size.height * 0.016),
            )),
        onEditingComplete: () {
          context.read<DemandaBloc>().add(DemandaFilter(
                // BACKEND
                'nome_demanda',
                _nomeDemanda.text,
              )); // BACKEND
        },
      ),
    );
  }
}
