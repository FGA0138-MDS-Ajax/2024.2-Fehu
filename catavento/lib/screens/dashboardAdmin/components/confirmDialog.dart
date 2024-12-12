import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String contente;
  final VoidCallback onConfirm;

  const ConfirmDialog({
    super.key,
    required this.title,
    required this.contente,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        contente,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      actions: <Widget>[
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 137,
              height: 57,
              child: ElevatedButton(
                  onPressed: onConfirm,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF50B432),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                  child: Text(
                    "Sim",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(
              width: 40,
            ),
            SizedBox(
              width: 137,
              height: 57,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFD54A3D),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22))),
                  child: Text(
                    "Não",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        )),
      ],
    );
  }
}
