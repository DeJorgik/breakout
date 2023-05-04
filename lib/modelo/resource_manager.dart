/*
 * Clase singleton que gestiona los datos persistentes de la app
 *
 */

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'modelo.dart';

class ResourceManager {


  //Constructor anonimo
  ResourceManager._();

  //Unica instancia
  static final ResourceManager RM = ResourceManager._();

  //devuelve la carpeta con las cosas
  Future<String> get localPath async {
    Directory directory = await
    getApplicationDocumentsDirectory();
    return directory.path;
  }

  //Referencia al archivo
  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/player.txt');
  }

  //Funcion que guarda los datos del jugador en el archivo, estando estos datos en el formato "record,color"
  Future<File> guardar() async {

    final file = await localFile;
    String color = '#${Jugador.JugadorInstancia.skin.value.toRadixString(16)}';
    return file.writeAsString('${Jugador.JugadorInstancia.record},$color');
  }

  //Funcion que carga los datos (hacer al principio del juego)
  cargar() async {

    final file = await localFile;
    final contents = await file.readAsString();
    final datos = contents.split(',');

    Jugador.JugadorInstancia.record = int.parse(datos[0]);
    String hexCodeSkin = datos[1];
    final hexCodeWithoutHash = hexCodeSkin.replaceAll('#', '');
    final intColor = int.parse(hexCodeWithoutHash, radix: 16);
    Jugador.JugadorInstancia.skin = Color(intColor);

  }

}