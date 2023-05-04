import 'package:breakout/vistas/vistas.dart';
import 'package:flutter/material.dart';
import 'package:breakout/modelo/modelo.dart';

/*
Clase que define el menu de Game Over
 */

class Game_Over extends StatelessWidget {
  const Game_Over({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){

    //Guardar datos del jugador (nuevo record)
    ResourceManager.RM.guardar();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "GAME OVER",
                  style: Estilos.EstiloInstancia.titulo
                ),
                Estilos.EstiloInstancia.separador,
                const Text(
                  "Puntuación:",
                  textScaleFactor: 1.5,
                  style: TextStyle(
                      fontFamily: 'VT323'
                  ),
                ),
                Estilos.EstiloInstancia.separador,
                Text(
                  "${Jugador.JugadorInstancia.puntuacion_actual}",
                  style: Estilos.EstiloInstancia.titulo2
                ),
                Estilos.EstiloInstancia.separador,
                //El mensaje solo se muestra cuando hay un nuevo récord
                (Jugador.JugadorInstancia.puntuacion_actual == Jugador.JugadorInstancia.record) ?
                const Text(
                  "NUEVO RECORD!",
                  style: TextStyle(
                      fontFamily: 'VT323'
                  ),
                  textScaleFactor: 1.5,
                ) : const SizedBox(),
                Estilos.EstiloInstancia.separador,
                SizedBox(
                  width: Pantalla.PantallaInstancia.ancho/2,
                  child: ElevatedButton(
                      //Resetear
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Pantalla_Juego()), (e) => false),
                      style: Estilos.EstiloInstancia.estiloboton2,
                      child: Text(
                        "REINICIAR",
                        style: Estilos.EstiloInstancia.texto2,
                      )
                  ),
                ),
                SizedBox(
                  width: Pantalla.PantallaInstancia.ancho/2,
                  child: ElevatedButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Menu_Principal())
                      ),
                      style: Estilos.EstiloInstancia.estiloboton2,
                      child: Text(
                        "SALIR",
                        style: Estilos.EstiloInstancia.texto2,
                      )
                  ),
                ),
              ]
          )
        )
      )
    );
  }
}
