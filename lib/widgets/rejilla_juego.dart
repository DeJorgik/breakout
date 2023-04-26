import 'dart:math';
import 'package:breakout/vistas/game_over.dart';
import 'widgets.dart';
import 'package:flutter/material.dart';
import 'package:breakout/modelo/modelo.dart';
import 'package:breakout/vistas/vistas.dart';

import 'ladrillo.dart';

class RejillaJuego extends StatefulWidget {
  const RejillaJuego({Key? key}) : super(key: key);
  @override
  State<RejillaJuego> createState() => _RejillaJuegoState();
}

//Enum con las direcciones posibles
enum Direccion {
  arriba,
  abajo,
  izquierda,
  derecha,
}

class _RejillaJuegoState extends State<RejillaJuego>
    with SingleTickerProviderStateMixin {

  //Info de la animación
  late AnimationController controladorAnimacion;
  late double animacion;

  //Direcciones que se permiten
  var direccionVertical = Direccion.abajo;
  var direccionHorizontal = Direccion.derecha;

  //Info de la rejilla de juego
  late double anchoRejilla = 0;
  late double altoRejilla = 0;

  //Info juego
  late double incremento;

  //Info de la pelota y la raqueta
  late double xRaqueta;
  late double yRaqueta;
  late double xPelota;
  late double yPelota;
  late double diametroPelota;
  late double mitadPelota;
  double anchoRaqueta = 0.0;
  double altoRaqueta = 0.0;

  //Info de los ladrillos
  late double altoBrick;
  late double anchoBrick;
  late double brickMargin;
  int numRowBricks = 4; //Numero de listas de ladrillos
  int numColBricks = 4; //Lumero de columnas de ladrillos
  late int ladrillos_restantes = numRowBricks * numColBricks;
  List<List<int>> brick_vidas = [];

  //Funcion que salta al game over, va con un retardo deliberado tras 1 segundo
  void preguntarRepetirPartida(BuildContext context) async {
    await Future.delayed(const Duration(seconds:1));
    Navigator.push(context, MaterialPageRoute(builder: (context) => Game_Over()));
  }

  //Función que determina qué pasa ccuando la pelota choca con un borde o con la raqueta
  void comprobarBordes() {
    if (anchoRejilla == 0.0 || altoRejilla == 0.0) {
      return;
    }
    double bordeDerecho = anchoRejilla - diametroPelota;
    double bordeInferior = altoRejilla - diametroPelota - altoRaqueta - yRaqueta;
    if (xPelota <= 0 && direccionHorizontal == Direccion.izquierda) {
      direccionHorizontal = Direccion.derecha;
    } else if (xPelota >= bordeDerecho &&
        direccionHorizontal == Direccion.derecha) {
      direccionHorizontal = Direccion.izquierda;
    }
    if (yPelota <= 0 && direccionVertical == Direccion.arriba) {
      direccionVertical = Direccion.abajo;
    } else if (yPelota - altoRaqueta + mitadPelota >= bordeInferior &&
        direccionVertical == Direccion.abajo) {
      if (xPelota >= (xRaqueta - mitadPelota) &&
          xPelota <= (xRaqueta + anchoRaqueta + mitadPelota)) {
        direccionVertical = Direccion.arriba;
      } else {
        controladorAnimacion.stop();
        preguntarRepetirPartida(context);
      }
    }
  }

  //Funcion que determina el movimiento de la raqueta
  //Evita que se salga de los bordes del mapa
  void moverRaqueta(DragUpdateDetails detalleDeslizar){
    setState(() {
      xRaqueta += detalleDeslizar.delta.dx;
      if (xRaqueta >= anchoRejilla - anchoRaqueta) {
        xRaqueta = anchoRejilla - anchoRaqueta;
      } if (xRaqueta <= 0) {
        xRaqueta = 0;
      }
    });
  }

  //Funcion que determina que pasa cuando la pelota golpea un ladrillo
  void comprobarHitBrick() {
    for (int i = 0; i < numRowBricks; i++) {
      for (int j = 0; j < numColBricks; j++) {
        if (brick_vidas[i][j] > 0) {
          double brickX = j * (anchoBrick + brickMargin);
          double brickY = i * (altoBrick + brickMargin);
          if (xPelota >= brickX &&
  xPelota <= brickX + anchoBrick &&
  yPelota >= brickY &&
  yPelota <= brickY + altoBrick) {
            setState(() {
              // le restamos 1 vida al brick que hemos golpeado y si llega a 0 ya no aparece mas
              brick_vidas[i][j] = brick_vidas[i][j] - 1;
              //Aumentar puntuación actual
              Jugador.JugadorInstancia.puntuacion_actual++;
              //Comprobar el récord
              comprobarRecord();
              if (brick_vidas[i][j] == 0) {
                ladrillos_restantes--;
              }
              if (ladrillos_restantes == 0) {

                //Se reseta la posición de la pelota
                xPelota = Pantalla.PantallaInstancia.ancho/2 -( Pantalla.PantallaInstancia.ancho/15)/2 -1;
                yPelota = Pantalla.PantallaInstancia.alto - (Pantalla.PantallaInstancia.ancho/5) * 3;
                //ir pa arriba
                direccionHorizontal = Direccion.izquierda;
                direccionVertical = Direccion.arriba;

                //Aumenta velocidad
                setState(() {
                  incremento++;
                });

                //Regenerar larillos
                regenerarLadrillos();
              }
            });

            if (direccionVertical == Direccion.arriba) {
              direccionVertical = Direccion.abajo;
            } else {
              direccionVertical = Direccion.arriba;
            }
          }
        }
      }
    }
  }

  //Funcion que crea un nuevo set de ladrillos
  void regenerarLadrillos() {
    Random random = new Random();
    brick_vidas =
        List.generate(numRowBricks, (index) => List.filled(numColBricks, 0));
    for (int i = 0; i < numRowBricks; i++) {
      for (int j = 0; j < numColBricks; j++) {
        brick_vidas[i][j] = random.nextInt(3) + 1;
      }
    }
    ladrillos_restantes = numColBricks * numRowBricks;
  }

  //Funcion que actualiza el valor del record
  void comprobarRecord(){
    setState(() {
      Jugador.JugadorInstancia.record = max(Jugador.JugadorInstancia.record, Jugador.JugadorInstancia.puntuacion_actual);
    });
  }

  //TODO Cuenta atras

  @override
  void initState() {

    //Inicialización
    xRaqueta = Pantalla.PantallaInstancia.ancho/2 - (Pantalla.PantallaInstancia.ancho/5)/2;
    incremento = 2.0;
    diametroPelota = Pantalla.PantallaInstancia.ancho/15;
    mitadPelota = diametroPelota / 2.0;
    xPelota = Pantalla.PantallaInstancia.ancho/2 -( Pantalla.PantallaInstancia.ancho/15)/2 -1;
    yPelota = Pantalla.PantallaInstancia.alto - (Pantalla.PantallaInstancia.ancho/5) * 4;
    yRaqueta = Pantalla.PantallaInstancia.ancho/15;//para que haya un margen entre la raqueta y el borde de la pantalla

    //Cuando empieza la partida, la puntuacion actual es 0
    Jugador.JugadorInstancia.puntuacion_actual = 0;

    controladorAnimacion = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    regenerarLadrillos();

    controladorAnimacion.addListener(() {
      setState(() {
        (direccionHorizontal == Direccion.derecha)
            ? xPelota += incremento
            : xPelota -= incremento;
        (direccionVertical == Direccion.abajo)
            ? yPelota += incremento
            : yPelota -= incremento;
      });
      comprobarBordes();
      comprobarHitBrick();
    });

    super.initState();

    controladorAnimacion.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 80,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: (){

                      //Pausar animación
                      controladorAnimacion.stop();

                      //Entrar en la pantalla de pausa
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Pausa()));

                      //Retardo deliberado para que no sea tan brusco

                      controladorAnimacion.forward();

                    },
                    icon: const Icon(Icons.pause, color: Colors.black, size: 30)),
                Text(
                  "${Jugador.JugadorInstancia.puntuacion_actual}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Record: ${Jugador.JugadorInstancia.record}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
           Expanded(
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  anchoRejilla = constraints.maxWidth;
                  altoRejilla = constraints.maxHeight;
                  anchoRaqueta = anchoRejilla / 5.0;
                  altoRaqueta = altoRejilla / 20.0;
                  brickMargin = 2.0;
                  anchoBrick = (anchoRejilla / (numColBricks)) - brickMargin;
                  altoBrick = altoRejilla / 15;

                  return Stack(children: <Widget>[
                    for (int i = 0; i < numRowBricks; i++)
                      for (int j = 0; j < numColBricks; j++)
                        if (brick_vidas[i][j] > 0)
                          Positioned(
                            top: i * (altoBrick + brickMargin),
                            left: j * (anchoBrick + brickMargin),
                            child: Ladrillo(
                              ancho: anchoBrick,
                              alto: altoBrick,
                              vida: brick_vidas[i][j],
                            ),
                          ),
                    Positioned(
                      top: yPelota,
                      left: xPelota,
                      child: Pelota(
                        diametro: diametroPelota,
                        color: Jugador.JugadorInstancia.skin //Skin Elegida
                      ),
                    ),
                    Positioned(
                      bottom: yRaqueta,
                      left: xRaqueta,
                      child: GestureDetector(
                          onHorizontalDragUpdate: (DragUpdateDetails detalleDeslizar) {
                            moverRaqueta(detalleDeslizar);
                          },
                          child: Raqueta(
                            anchura: anchoRaqueta,
                            altura: altoRaqueta,
                              color: Jugador.JugadorInstancia.skin //Skin Elegida
                          )),
                    ),
                  ]);
                })
          ),
        ],
      ),
    );
  }
}

