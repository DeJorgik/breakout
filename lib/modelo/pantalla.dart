import 'package:flutter/material.dart';

/*
 *Singleton que guarda las dimensiones de la pantalla
 */

class Pantalla{

  //Atributos
  double ancho = 0;
  double alto = 0;

  //Única instancia de la clase
  static final Pantalla PantallaInstancia = Pantalla._();

  //Constructor privado
  Pantalla._();

}