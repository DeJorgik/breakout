import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ladrillo extends StatelessWidget {
  final double ancho;
  final double alto;
  final int vida;
  const Ladrillo(
      {Key? key, required this.ancho, required this.alto, required this.vida})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color_brick;
    if (vida == 1) {
      color_brick = Colors.yellow;
    } else if (vida == 2) {
      color_brick = Colors.orange;
    } else if (vida == 3) {
      color_brick = Colors.red;
    } else if (vida == 4) {
      color_brick = Colors.pink;
    } else if (vida == 5){
      color_brick = Colors.purple;
    } else if (vida == 6){
      color_brick = Colors.blue;
    } else if (vida == 7){
      color_brick = Colors.cyanAccent;
    } else if (vida == 8){
      color_brick = Colors.lightGreenAccent;
    } else if (vida == 9){
      color_brick = Colors.green;
    } else {
      color_brick = Colors.black;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color_brick,
      ),
      height: alto,
      width: ancho,
    );
  }
}
