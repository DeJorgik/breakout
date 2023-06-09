import 'package:flutter/material.dart';

//Clase  singletonque define los estilos
class Estilos {
  //Fuentes
  final TextStyle titulo = const TextStyle(
      fontSize: 75,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'VT323',
  );

  final TextStyle titulo2 = const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'VT323',
  );

  final TextStyle texto1 = const TextStyle(
      fontSize: 55,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: 'VT323',
  );

   final TextStyle texto2 = const TextStyle(
      fontSize: 35,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontFamily: 'VT323',
  );

  final TextStyle texto3 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w300,
      color: Colors.black,
      fontFamily: 'VT323',
  );

  //Estilo de botones
  final ButtonStyle estiloboton1 = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          )
      )
  );

  final ButtonStyle estiloboton2 = const ButtonStyle(
      backgroundColor: MaterialStatePropertyAll<Color>(Colors.orange),
      shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))
          )
      ),
  );

  //Separador constante que separa los elementos de la lista
  //Se usa para cumplir DRY
  //privado pq solo se usa en esta vista
  final SizedBox separador = const SizedBox(
    height: 25,
    width: 25,
  );

  //Constructor anonimo
  Estilos._();

  //Unica instancia
  static final Estilos EstiloInstancia = Estilos._();

}
