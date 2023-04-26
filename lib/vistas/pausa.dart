import 'package:breakout/vistas/vistas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout/modelo/modelo.dart';

/*
Clase que define el menu de pausa
 */

class Pausa extends StatelessWidget {
  const Pausa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                    "PAUSA",
                    style: GoogleFonts.vt323(
                        textStyle: Estilos.EstiloInstancia.titulo
                    )
                ),
                Estilos.EstiloInstancia.separador,
                SizedBox(
                  width: Pantalla.PantallaInstancia.ancho/2,
                  child: ElevatedButton(
                      onPressed: () => Navigator.pop(context), //Volver a la pantalla de juego, continuando
                      style: Estilos.EstiloInstancia.estiloboton2,
                      child: Text(
                        "CONTINUAR",
                        style: GoogleFonts.vt323(
                          textStyle: Estilos.EstiloInstancia.texto2,
                        ),
                      )
                  ),
                ),
                SizedBox(
                  width: Pantalla.PantallaInstancia.ancho/2,
                  child: ElevatedButton(
                    //Volver a la pantalla de juego reseteando
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Pantalla_Juego()), (e) => false),
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
                    //Volver a la pantalla de menu reseteando
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Menu_Principal()), (e) => false),
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
