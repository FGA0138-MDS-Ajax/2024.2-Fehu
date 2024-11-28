import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'csv_import_service.dart';
Future<String?> tablePicker() async {//retorna o caminho do arquivo
  try{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.single.path; //retornar caminho do arquivo

    }
  } catch(e){
    print("Erro escolhendo o arquivo: $e");
  }
  return null;//nulo se nenhum arquivo foi selecionado ou se um erro aconteceu
  
}
