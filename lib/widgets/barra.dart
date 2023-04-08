import 'package:flutter/material.dart';

/*
 * Clase de la Barra
 */

class Barra extends StatelessWidget {

  //tamaño de la barra
  final double anchura;
  final double altura;

  //Color de la barra
  final Color color;

  Barra({Key? key, this.anchura = 45, this.altura = 15, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {

    return Container(
      width: anchura,
      height: altura,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(
              width: 5,
              color: Colors.black
          )
      ),
    );
  }
}