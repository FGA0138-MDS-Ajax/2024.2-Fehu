import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class Graficinfo<B extends BlocBase<S>, S> extends StatefulWidget {
  final IconData icons;
  final Color colorIcons;
  final String info;
  final String? dataKey;
  final BlocBuilderCondition<S>? buildWhen;

  Graficinfo ({
    required this.icons,
    required this.colorIcons,
    required this.info,
    this.dataKey,
    this.buildWhen,

  });

  @override
  State<Graficinfo<B, S>> createState() {
    return GraficinfoState<B, S>();
  }
}

class GraficinfoState<B extends BlocBase<S>, S> extends State<Graficinfo<B, S>> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      buildWhen: widget.buildWhen,
      builder: (context, response) {
        final metaData = (response as dynamic).metaData;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(top: 30.0, bottom: 10.0, left: 60.0),
              child: Icon(
                widget.icons,
                size: 80.0,
                color: widget.colorIcons,
              ),
            ),
            SizedBox(
              width: 40,
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${metaData[widget.dataKey] ?? '--'}",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    widget.info,
                    style:
                        TextStyle(fontSize: 18, color: Colors.black),
                  )
                ],
              )
            ),
          ],
        );
      }
    );
  }
}