import 'package:flutter/material.dart';

// BACKEND
import 'package:catavento/bloc/demanda/demanda_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// components
import 'package:catavento/screens/DashboardAdmin/components/graph.dart';
import 'package:catavento/shared/widgets/blocks.dart';
import 'package:catavento/shared/theme/colors.dart';

class QuadroGrafico extends StatefulWidget {
  const QuadroGrafico({super.key});

  @override
  State<QuadroGrafico> createState() {
    return QuadroGraficoState();
  }
}

class QuadroGraficoState extends State<QuadroGrafico> {
  final List<Color> colors = [AppColors.gradientDarkBlue, AppColors.mediumPink];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<DemandaBloc, DemandaState>(
      buildWhen: (previous, current) => current is! DemandaFilterState,
      builder: (context, response) {
        final metaData = response.metaData;

        return Container(
          width: size.width * 0.9,
          height: size.height * 0.65,
          child: Column(
            children: [
              // Primeiro Card - Gráfico
              Blocks(
                height: size.height * 0.2,
                color: AppColors.lightGray,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: colors[0],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Completas: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.gradientDarkBlue,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    "${metaData['completo']}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.gradientDarkBlue,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: colors[1],
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("Restantes: ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.gradientDarkBlue,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  Text(
                                    "${metaData['restantes']}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: AppColors.gradientDarkBlue,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Total: ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.gradientDarkBlue,
                                    fontFamily: 'FredokaOne'),
                              ),
                              Text(
                                "${metaData['total']}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gradientDarkBlue,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: PizzaChart(
                          completas: metaData['completo'] ?? 0,
                          restantes: metaData['restantes'] ?? 0,
                          colors: [
                            AppColors.gradientDarkBlue,
                            AppColors.mediumPink
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 15),

              // Segundo Card - Status de Fabricação
              Blocks(
                height: size.height * 0.2,
                color: AppColors.lightGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        Icons.cake_rounded,
                        size: 60,
                        color: AppColors.mediumPink,
                      ),
                    ),
                    SizedBox(width: 30),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${metaData['fabricacao']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'FredokaOne',
                              color: AppColors.gradientDarkBlue,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Em fabricação",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gradientDarkBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 15),

              // Terceiro Card - Status de Espera
              Blocks(
                height: size.height * 0.2,
                color: AppColors.lightGray,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [
                              AppColors.gradientDarkBlue,
                              AppColors.gradientLightBlue
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Icon(
                          Icons.layers,
                          size: 60,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 50),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${metaData['espera']}",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'FredokaOne',
                              color: AppColors.gradientDarkBlue,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Em espera",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.gradientDarkBlue),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
