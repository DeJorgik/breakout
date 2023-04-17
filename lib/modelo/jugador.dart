import 'package:flutter/material.dart';
/*
Clase Singleton que guarda las varibles globales del jugador
 */

class Jugador{

  //Record
  int record = 0;

  //Skin (Color que tiene equipado en la bola y la barra)
  Color skin = Colors.white;

  //Constructor anonimo
  Jugador._();

  //Unica instancia
  static final Jugador JugadorInstancia = Jugador._();

}