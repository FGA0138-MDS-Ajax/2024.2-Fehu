import 'package:flutter/material.dart';

class StageDemand extends StatelessWidget {
  const StageDemand({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 432,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: status == "finished"
            ? Color(0xFF50b432)
            : status == "InProgress"
                ? Color(0xFFFFCC00)
                : Color(0xFFED561B),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Etapa 1 {nome Etapa}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Icon(
              status == "finished"
                  ? Icons.check
                  : status == "InProgress"
                      ? Icons.access_time
                      : Icons.close,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
