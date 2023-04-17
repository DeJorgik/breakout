import 'package:breakout/vistas/vistas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout/modelo/modelo.dart';

/*
Clase que define el menu de Game Over
 */

class Game_Over extends StatelessWidget {
  const Game_Over({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "GAME OVER",
                  style: GoogleFonts.vt323(
                      textStyle: Estilos.EstiloInstancia.titulo
                  ),
                ),
                Estilos.EstiloInstancia.separador,
                Text(
                  "Puntuación:",
                  style: GoogleFonts.vt323(),
                  textScaleFactor: 1.5,
                ),
                Estilos.EstiloInstancia.separador,
                Text(
                  "567",
                  style: GoogleFonts.vt323(
                    textStyle: Estilos.EstiloInstancia.titulo2
                  ),
                ),
                Estilos.EstiloInstancia.separador,
                Text(
                  "NUEVO RECORD!",
                  style: GoogleFonts.vt323(),
                  textScaleFactor: 1.5,
                ),
                Estilos.EstiloInstancia.separador,
                SizedBox(
                  width: Pantalla.PantallaInstancia.ancho/2,
                  child: ElevatedButton(
                      onPressed: () => 0,
                      style: Estilos.EstiloInstancia.estiloboton2,
                      child: Text(
                        "REINICIAR",
                        style: GoogleFonts.vt323(
                          textStyle: Estilos.EstiloInstancia.texto2,
                        ),
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
                        style: GoogleFonts.vt323(
                          textStyle: Estilos.EstiloInstancia.texto2,
                        ),
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
