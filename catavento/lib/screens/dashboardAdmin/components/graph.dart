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
          width: constraints.maxWidth, // Largura total disponível
          height: constraints.maxHeight, // Altura total disponível
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: completasPercent * 100, // Percentual de completas
                  title: '${(completasPercent * 100).toStringAsFixed(1)}%',
                  color: colors[0],
                  radius:
                      constraints.maxWidth * 0.3, // Ajusta com base no tamanho
                ),
                PieChartSectionData(
                  value: restantesPercent * 100, // Percentual de restantes
                  title: '${(restantesPercent * 100).toStringAsFixed(1)}%',
                  color: colors[1],
                  radius:
                      constraints.maxWidth * 0.3, // Ajusta com base no tamanho
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
