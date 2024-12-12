import 'package:flutter/material.dart';

class ReducedDemandCard extends StatelessWidget {
  final String demanda;

  const ReducedDemandCard({required this.demanda, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.cake, color: Color(0xFF015C98)),
          const SizedBox(width: 8),
          Text(demanda),
        ],
      ),
    );
  }
}
