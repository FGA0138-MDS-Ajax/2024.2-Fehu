import 'dart:io';
import 'package:csv/csv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> importCSVtoSupabase(String csvFilePath) async {
  final supabase = Supabase.instance.client;

  final csvFile = File(csvFilePath);
  final csvContent = await csvFile.readAsString();

  final csvData = CsvToListConverter().convert(csvContent, eol: '\n');

  final columnNames = csvData.first; // primeira linha contem os nomes
  print(columnNames);
  final dataRows = csvData.skip(1); // nao ler a primeira linha
  print(dataRows);
  final dataList = dataRows.map((row) {
    return Map<String, dynamic>.fromIterables(
        columnNames.map((e) => e.toString()), row.map((e) => e));
  }).toList();

  try {
    final response = await supabase.from('demandas').insert(dataList);

    if (response.isNotEmpty) {
      print('inserida com sucesso: ${response.length} ');
    } else {
      print('Dados nao foram inseridos.');
    }
  } catch (e) {
    print('erro: $e');
  }
}
