import 'package:flutter/material.dart';

/*
 * Clase De la Pelota
 */

class Pelota extends StatelessWidget {

  //Tamaño de la pelota
  final double diametro;

  //Color de la pelota
  final Color color;

  Pelota({Key? key, this.diametro = 25, this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diametro,
      height: diametro,
      decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
              width: 5,
              color: Colors.black
          )
      ),
    );
  }
}
