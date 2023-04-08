import 'package:flutter/material.dart';

//Clase  singletonque define los estilos
class Estilos {
  //Fuentes
  final TextStyle titulo = const TextStyle(
      fontSize: 65,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  final TextStyle titulo2 = const TextStyle(
      fontSize: 50,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );

  final TextStyle texto1 = const TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w500,
      color: Colors.white
  );

   final TextStyle texto2 = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w400,
      color: Colors.white
  );

  final TextStyle texto3 = const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w300,
      color: Colors.black
  );

  //Estilo de botones
  final ButtonStyle estiloboton1 = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          )
      )
  );

  final ButtonStyle estiloboton2 = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          )
      )
  );

  //Constructor anonimo
  Estilos._();

  //Unica instancia
  static final Estilos EstiloInstancia = Estilos._();

}
