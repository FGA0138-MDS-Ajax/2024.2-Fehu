import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:catavento/shared/theme/colors.dart';

class Graficinfo<B extends BlocBase<S>, S> extends StatefulWidget {
  final double? size;
  final IconData icons;
  final Color colorIcons;
  final String info;
  final String dataKey;
  final BlocBuilderCondition<S> buildWhen;

  Graficinfo({
    this.size,
    required this.icons,
    required this.colorIcons,
    required this.info,
    required this.dataKey,
    required this.buildWhen,
  });

  @override
  State<Graficinfo<B, S>> createState() {
    return GraficinfoState<B, S>();
  }
}

class GraficinfoState<B extends BlocBase<S>, S>
    extends State<Graficinfo<B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
        buildWhen: widget.buildWhen,
        builder: (context, response) {
          final metaData = (response as dynamic).metaData;

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  widget.icons,
                  size: widget.size,
                  color: widget.colorIcons,
                ),
                SizedBox(width: 20),
                Center(
                  // Adicionado Center para centralizar o conteúdo dentro do Column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment
                        .start, // Centralizado horizontalmente
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${metaData[widget.dataKey] ?? '--'}",
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'FredokaOne',
                          color: AppColors.gradientDarkBlue,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        widget.info,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.gradientDarkBlue),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
