import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PizzaChart extends StatelessWidget {
  final int completas;
  final int restantes;
  final List<Color> colors;

  const PizzaChart({
    super.key,
    required this.completas,
    required this.restantes,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final total = completas + restantes;
    final completasPercent = completas / total;
    final restantesPercent = restantes / total;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth * 0.4,
          height: constraints.maxHeight * 0.4,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: completasPercent * 100,
                  title: '${(completasPercent * 100).toStringAsFixed(1)}%',
                  color: colors[0],
                  radius: constraints.maxWidth * 0.3,
                ),
                PieChartSectionData(
                  value: restantesPercent * 100,
                  title: '${(restantesPercent * 100).toStringAsFixed(1)}%',
                  color: colors[1],
                  radius: constraints.maxWidth * 0.3,
                ),
              ],
              centerSpaceRadius:
                  constraints.maxWidth * 0.15, // Espaço no centro
            ),
          ),
        );
      },
    );
  }
}

class ChartContainer extends StatelessWidget {
  final int completas;
  final int restantes;
  final List<Color> colors;

  const ChartContainer({
    super.key,
    required this.completas,
    required this.restantes,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Row(
          children: [
            // Texto à esquerda
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Completas: $completas",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Restantes: $restantes",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Total: ${completas + restantes}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Gráfico à direita
            Expanded(
              flex: 3,
              child: PizzaChart(
                completas: completas,
                restantes: restantes,
                colors: colors,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
