import 'package:flutter/material.dart';
/*
Clase Singleton que guarda las varibles globales del jugador
 */

class Jugador{

  //Record
  int record = 0;

  //Puntuacion actual
  //La puntuación que el jugador consiguió en la última partida/ partida actual
  int puntuacion_actual = 0;

  //Skin (Color que tiene equipado en la bola y la barra)
  Color skin = Colors.white;

  //Constructor anonimo
  Jugador._();

  //Unica instancia
  static final Jugador JugadorInstancia = Jugador._();

}