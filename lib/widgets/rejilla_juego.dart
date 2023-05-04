import 'dart:math';
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
  nada //cuando solo se mueve en un eje, osea al principio del juego
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
  late int dificultad; //se usa para multiplicar el numero de ladrillos y la vida maxima de estos
  late String cuenta_atras;

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
    } else if (yPelota - altoRaqueta + yRaqueta/2 + mitadPelota >= bordeInferior &&
        direccionVertical == Direccion.abajo) {
      if (xPelota >= (xRaqueta - mitadPelota) &&
          xPelota <= (xRaqueta + anchoRaqueta + mitadPelota)) {
        direccionVertical = Direccion.arriba;
        //primer toque
        if(direccionHorizontal == Direccion.nada){
          direccionHorizontal = Direccion.derecha;
        }
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
              //Aumenta velocidad
              incremento+=0.005;
              //Comprobar el récord
              comprobarRecord();
              if (brick_vidas[i][j] == 0) {
                ladrillos_restantes--;
              }

              //Los ladrillos negros hacen que la pelota se haga mas pequeña
              if (brick_vidas[i][j] >= 9) {
                diametroPelota--;
              }

              if (ladrillos_restantes == 0) {

                //Aumenta velocidad
                incremento+=0.05;

                //Aumentar la dificultad
                aumentarDificultad();

                //Regenerar larillos
                regenerarLadrillos();

                //Poner pelota en posicion inicial
                comenzarPartida();
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
    brick_vidas = List.generate(numRowBricks, (index) => List.filled(numColBricks, 0, growable: true), growable: true);

    for (int i = 0; i < numRowBricks; i++) {
      for (int j = 0; j < numColBricks; j++) {
        brick_vidas[i][j] = random.nextInt(dificultad) + 1;
      }
    }

    ladrillos_restantes = numRowBricks*numColBricks;

  }

  //Funcion que actualiza el valor del record
  void comprobarRecord(){
    //Guardar récord en archivo
    //ResourceManager.ResourcemanagerInstancia.guardar();
    setState(() {
      Jugador.JugadorInstancia.record = max(Jugador.JugadorInstancia.record, Jugador.JugadorInstancia.puntuacion_actual);
    });
  }

  //TODO Cuenta atras
  void comenzarPartida() async {
    controladorAnimacion.stop();
    setState(() {
      direccionHorizontal = Direccion.nada;
      direccionVertical = Direccion.arriba;
      xPelota = xRaqueta + mitadPelota;
      yPelota = Pantalla.PantallaInstancia.alto/2 + altoRaqueta + yRaqueta/2 + mitadPelota;
    });
    setState(() {
      cuenta_atras = "3";
    });
    await Future.delayed(const Duration(milliseconds:500));
    setState(() {
      cuenta_atras = "2";
    });
    await Future.delayed(const Duration(milliseconds:500));
    setState(() {
      cuenta_atras = "1";
    });
    await Future.delayed(const Duration(milliseconds:500));
    setState(() {
      cuenta_atras = "YA!";
    });
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      cuenta_atras = "";
    });
    controladorAnimacion.forward();
  }

  //Aumentar dificultad
  void aumentarDificultad(){
    setState(() {
        dificultad+=2;
      });
  }

  @override
  void initState() {

    //Inicialización
    xRaqueta = Pantalla.PantallaInstancia.ancho/2 - (Pantalla.PantallaInstancia.ancho/5)/2;
    incremento = 3.0;
    dificultad = 1;
    diametroPelota = Pantalla.PantallaInstancia.ancho/15;
    mitadPelota = diametroPelota / 2.0;
    xPelota = Pantalla.PantallaInstancia.ancho/2 -( Pantalla.PantallaInstancia.ancho/15)/2 -1;
    yPelota = Pantalla.PantallaInstancia.alto - (Pantalla.PantallaInstancia.ancho/5) * 4;
    yRaqueta = Pantalla.PantallaInstancia.alto/15;//para que haya un margen entre la raqueta y el borde de la pantalla

    //Cuando empieza la partida, la puntuacion actual es 0
    Jugador.JugadorInstancia.puntuacion_actual = 0;

    controladorAnimacion = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );

    cuenta_atras = "";

    regenerarLadrillos();

    controladorAnimacion.addListener(() {
      setState(() {
        if(direccionHorizontal != Direccion.nada) {
          (direccionHorizontal == Direccion.derecha)
              ? xPelota += incremento
              : xPelota -= incremento;
        }
        (direccionVertical == Direccion.abajo)
            ? yPelota += incremento
            : yPelota -= incremento;
      });
      comprobarBordes();
      comprobarHitBrick();
    });

    super.initState();

    comenzarPartida();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                    onPressed: (){

                      //Pausar animación
                      controladorAnimacion.stop();

                      //Entrar en la pantalla de pausa
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const Pausa()));

                      controladorAnimacion.forward();

                    },
                    icon: const Icon(Icons.pause, color: Colors.black, size: 30)),
               Text(
                  "${Jugador.JugadorInstancia.puntuacion_actual}",
                 textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontFamily: 'VT323',
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  "Record:\n ${Jugador.JugadorInstancia.record}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'VT323'
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
                      bottom:Pantalla.PantallaInstancia.alto/3,
                        child: SizedBox(
                          width: Pantalla.PantallaInstancia.ancho,
                          child: Text("$cuenta_atras",
                            style: Estilos.EstiloInstancia.titulo,
                            textAlign: TextAlign.center,
                          )
                        )
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

