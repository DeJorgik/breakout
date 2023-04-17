import 'package:flutter/material.dart';

/*
Objeto que se añade a la lista de items de tienda
 */

class Item_Tienda{


  final int id;
  final Color color;
  final int precio;
  bool desbloqueado;

  Item_Tienda({
    required this.id,
    required this.color,
    required this.precio,
    this.desbloqueado = false,
  });

}