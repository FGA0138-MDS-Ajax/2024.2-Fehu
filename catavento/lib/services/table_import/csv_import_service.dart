import 'dart:io';
import 'package:csv/csv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:excel/excel.dart';

Future<void> importExcelToSupabase(String filePath) async {
  final supabase = Supabase.instance.client;
  try {
    final fileBytes = File(filePath).readAsBytesSync();
    final excel = Excel.decodeBytes(fileBytes);

    for (var sheetName in excel.tables.keys) {
      final sheet = excel.tables[sheetName];

      if (sheet != null) {
        print('processando planilha: $sheetName');
        for (var row in sheet.rows) {
          // mapear os valores das celular para uma lista de dados puros
          final rowData = row.map((cell) => cell?.value?.toString() ?? '').toList();

         
          print('daddos da linha: $rowData');

          // verifica a validade da coluna (se é nula ou vazia)
          if (rowData.isNotEmpty && rowData.first.isNotEmpty) {
            try {
              
              final Map<String, dynamic> parsedData = {
                'nomeDemanda': rowData[0],         
                'funcionario': rowData[1].isNotEmpty == true ? rowData[1] : 0, 
                //'outrosDados': int.tryParse(rowData[2]) ?? 0.0, // 
              };

              
              print('dados lidos: $parsedData');
             
       await supabase.from('demandas').insert(parsedData);

            } catch (e) {
              print('erro: $e');
            }
          }
        }
      }
    }
  } catch (e) {
    print('erro ao importar o arquivo: $e');
  }
}
