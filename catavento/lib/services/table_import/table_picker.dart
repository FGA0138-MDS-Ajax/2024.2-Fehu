import 'package:file_picker/file_picker.dart';

Future<String?> tablePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    dialogTitle: "Escolha a planilha",
    type: FileType.custom,
    allowedExtensions: ['xlsx', 'csv'],
  );

  if (result != null) {
    final file = result.files.first;
    return file.path;
  }

  return null;
}
