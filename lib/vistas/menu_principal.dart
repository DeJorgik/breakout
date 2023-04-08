import 'package:breakout/vistas/como_jugar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout/modelo/modelo.dart';

/*
 * Menu Principal del juego
 */

class Menu_Principal extends StatelessWidget {
  const Menu_Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {

          //Inicializar valores del tamaño de pantalla
          Pantalla.PantallaInstancia.alto = constraints.maxHeight;
          Pantalla.PantallaInstancia.ancho = constraints.maxWidth;

          //Devolver la vista
          return SafeArea(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "BREAKOUT",
                      style: GoogleFonts.vt323(
                          textStyle: Estilos.EstiloInstancia.titulo
                      ),
                    ),
                    const SizedBox(
                        height: 5
                    ),
                    Text(
                        "Récord: 66666",
                        style: GoogleFonts.vt323(
                            textStyle: Estilos.EstiloInstancia.texto3
                        )
                    ),
                    const SizedBox(
                        height: 10
                    ),
                    ElevatedButton(
                        onPressed: () => 0,
                        style: Estilos.EstiloInstancia.estiloboton1,
                        child: Text(
                            " JUGAR! ",
                            style: GoogleFonts.vt323
                              (textStyle: Estilos.EstiloInstancia.texto1
                            )
                        )
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () => 0,
                        style: Estilos.EstiloInstancia.estiloboton2,
                        child: Text(
                          "TIENDA",
                          style: GoogleFonts.vt323(
                            textStyle: Estilos.EstiloInstancia.texto1,
                          ),
                        )
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                        onPressed: () =>  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Como_Jugar())
                        ),
                        style: Estilos.EstiloInstancia.estiloboton2,
                        child: Text(
                            "CÓMO JUGAR",
                            style: GoogleFonts.vt323(
                                textStyle: Estilos.EstiloInstancia.texto2
                            )
                        )
                    ),
                  ],
                )
              )
          );
        }
      )
    );
  }
}
