import 'dart:math';
import 'widgets.dart';
import 'package:flutter/material.dart';
//import 'package:path_provider/';

import 'brick.dart';

class RejillaJuego extends StatefulWidget {
  const RejillaJuego({Key? key}) : super(key: key);
  @override
  State<RejillaJuego> createState() => _RejillaJuegoState();
}

enum Direccion {
  arriba,
  abajo,
  izquierda,
  derecha,
}

class _RejillaJuegoState extends State<RejillaJuego>
    with SingleTickerProviderStateMixin {
  late AnimationController controladorAnimacion;
  late double xRaqueta;
  late double xPelota;
  late double yPelota;
  var direccionVertical = Direccion.abajo;
  var direccionHorizontal = Direccion.derecha;
  late double animacion;
  late double anchoRejilla = 0;
  late double altoRejilla = 0;
  late double diametroPelota;
  late double mitadPelota;
  int puntuacion = 0;
  late double incremento;
  double anchoRaqueta = 0.0;
  double altoRaqueta = 0.0;
  late double altoBrick;
  late double anchoBrick;
  late double brickMargin;
  int numRowBricks = 1;
  int numColBricks = 3;
  late int ladrillos_restantes = numRowBricks * numColBricks;
  List<List<int>> brick_vidas = [];

  void preguntarRepetirPartida(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Game Over',
              textAlign: TextAlign.center,
            ),
            content: Text(
              'Puntuación: $puntuacion\n¿Quieres jugar otra vez?',
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Si'),
                onPressed: () {
                  setState(() {
                    xPelota = 100.0;
                    yPelota = 300.0;
                    puntuacion = 0;
                  });
                  Navigator.of(context).pop();
                  controladorAnimacion?.repeat();
                },
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  dispose();
                },
              ),
            ],
          );
        });
  }

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
              puntuacion++;
              // le restamos 1 vida al brick que hemos golpeado y si llega a 0 ya no aparece mas
              brick_vidas[i][j] = brick_vidas[i][j] - 1;
              if (brick_vidas[i][j] == 0) {
                ladrillos_restantes--;
              }
              if (ladrillos_restantes == 0) {
                xPelota = 100.0;
                yPelota = 300.0;
                regenerarLadrillos(context);
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

  void comprobarBordes() {
    if (anchoRejilla == 0.0 || altoRejilla == 0.0) {
      return;
    }
    double bordeDerecho = anchoRejilla - diametroPelota;
    double bordeInferior = altoRejilla - diametroPelota - altoRaqueta;
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
        setState(() {
          incremento += 0.5;
        });
      } else {
        controladorAnimacion.stop();
        preguntarRepetirPartida(context);
      }
    }
  }

  void moverRaqueta(DragUpdateDetails detalleDeslizar) {
    setState(() {
      xRaqueta += detalleDeslizar.delta.dx;
      if (xPelota >= (xRaqueta - mitadPelota) &&
          xPelota <= (xRaqueta + anchoRaqueta - mitadPelota)) {
      } else if (xRaqueta >= anchoRejilla - anchoRaqueta) {
        xRaqueta = anchoRejilla - anchoRaqueta;
      }
    });
  }

  void regenerarLadrillos(BuildContext context) {
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

  @override
  void initState() {
    xRaqueta = 0.0;

    incremento = 5.0;
    xPelota = 100.0;
    yPelota = 300.0;
    diametroPelota = 40.0;
    mitadPelota = diametroPelota / 2.0;
    controladorAnimacion = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    regenerarLadrillos(context);

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
    return LayoutBuilder(
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
                child: Brick(
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
          ),
        ),
        Positioned(
          bottom: 0,
          left: xRaqueta,
          child: GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails detalleDeslizar) {
                moverRaqueta(detalleDeslizar);
              },
              child: Raqueta(
                anchura: anchoRaqueta,
                altura: altoRaqueta,
              )),
        ),
        Positioned(
          top: 12,
          right: 12,
          child: Text(
            'Puntuación: $puntuacion',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black38,
            ),
          ),
        ),
      ]);
    });
  }
}
