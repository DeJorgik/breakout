import 'package:breakout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout/modelo/modelo.dart';

/*
 * Pantalla de Como jugar
 */

class Como_Jugar extends StatelessWidget {
  const Como_Jugar({Key? key}) : super(key: key);

  //Separador constante que separa los elementos de la lista
  //Se usa para cumplir DRY
  //privado pq solo se usa en esta vista
  static const SizedBox _separador = SizedBox(
    height: 20,
    width: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 25,
                child: Text(
                    "CÓMO JUGAR",
                  style: GoogleFonts.vt323(
                    textStyle: Estilos.EstiloInstancia.titulo2
                  ),
                )
            ),
            Positioned(
              top: 100,
              child: Container(
                height: Pantalla.PantallaInstancia.alto-200,
                width: Pantalla.PantallaInstancia.ancho-50,
                child: ListView(
                  children: <Widget>[
                    Text(
                      "Breakout está basado en el clásico juego de Atari en el que se controla una raqueta que debe impactar con una pelota para destruir unos ladrillos.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Text(
                      "El objetivo del juego es romper todos los ladrillos sin que la pelota se salga por debajo de la pantalla, en cuyo caso el juego terminará.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Barra(
                      anchura: 15,
                    ),
                    _separador,
                    Text(
                      "Para mover la raqueta, basta con pulsar en ella y deslizar el dedo por la pantalla.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Pelota(),
                    _separador,
                    Text(
                      "Para destruir un ladrillo, la pelota debe chocar con el. Algunos ladrillos requieren que la pelota choque más de una vez. Cada ladrillo roto suma un punto.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Text(
                      "Cada vez que la pelota rebote con la raqueta, esta se moverá más rápido, haciendo el juego más difícil.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Text(
                      "Se pueden canjear los puntos ganados en la tienda para cambiar el color de la raqueta y la pelota.",
                      style: Estilos.EstiloInstancia.texto3,
                      textAlign: TextAlign.center,
                    ),
                    _separador,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Pelota(
                          color: Colors.red,
                        ),
                        _separador,
                        Pelota(
                          color: Colors.blue,
                        ),
                        _separador,
                        Pelota(
                          color: Colors.green,
                        ),
                        _separador,
                        Pelota(
                          color: Colors.pink,
                        ),
                        _separador,
                        Pelota(
                          color: Colors.yellow,
                        ),
                        _separador,
                        Pelota(
                          color: Colors.deepOrange,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]
                )
              )
            ),
            Positioned(
              bottom: 25,
              child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: Estilos.EstiloInstancia.estiloboton2,
                  child: Text(
                    "VOLVER",
                    style: GoogleFonts.vt323(
                        textStyle: Estilos.EstiloInstancia.texto2
                    ),
                  )
              )
            )
          ]
        )
      )
    );
  }
}
