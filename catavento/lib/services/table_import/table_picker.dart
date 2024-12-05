import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<String?> tablePicker() async {
  //retorna o caminho do arquivo
  try {
    final dir = await getDownloadsDirectory();
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      initialDirectory: dir!.path,
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.single.path;
      final file = File(path!);
      final newFileName = path.split('/').last;
      final newFilePath = '${dir.path}/$newFileName';
      final newFile = File('${dir.path}/$newFileName');

      if (!await newFile.exists()) {
        await file.copy(newFilePath);
      }

      return newFilePath;
    }
  } catch (e) {
    print("Erro escolhendo o arquivo: $e");
  }
  return null; //nulo se nenhum arquivo foi selecionado ou se um erro aconteceu
}
