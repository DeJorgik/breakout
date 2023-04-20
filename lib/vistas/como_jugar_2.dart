import 'package:breakout/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:breakout/modelo/modelo.dart';

/*
 * Pantalla de Como jugar
 */


class Como_Jugar extends StatefulWidget {
  const Como_Jugar({Key? key}) : super(key: key);

  @override
  State<Como_Jugar> createState() => _Como_JugarState();
}

class _Como_JugarState extends State<Como_Jugar> {

  late int id_instruccion;
  late String texto_instruccion;
  static const List<String> instrucciones = [
    "El objetivo del juego es romper todos los ladrillos usando la pelota.",
    "Desliza la raqueta con el dedo para que la pelota rebote.",
    "Si la pelota cae al suelo, ¡Game over!",
    "Algunos ladrilos necesitan más golpes para romperse.",
    "Cuanto más alto sea tu récord, más colores nuevos podrás desbloquear en la tienda.",
  ];

  @override //inicializar variable
  void initState() {
    id_instruccion = 0;
    texto_instruccion = instrucciones[id_instruccion];
    super.initState();
  }

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
                    top: Pantalla.PantallaInstancia.alto-(Pantalla.PantallaInstancia.alto-150),
                    child: Text(
                      "[${id_instruccion+1}/5]",
                      textAlign: TextAlign.center,
                      textScaleFactor: 1.3,
                      ),
                    ),
                  Positioned(
                    top: Pantalla.PantallaInstancia.alto-(Pantalla.PantallaInstancia.alto-200),
                    child: Container(
                      height: (Pantalla.PantallaInstancia.alto-200)/2,
                      width: Pantalla.PantallaInstancia.ancho - 50,
                      child: Text(
                        texto_instruccion,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                  Positioned(
                      top: Pantalla.PantallaInstancia.alto-(Pantalla.PantallaInstancia.alto-200)+100,
                      left: Pantalla.PantallaInstancia.ancho/2 + 45,
                      child: IconButton(
                          onPressed: () {

                            id_instruccion+=1;
                            if(id_instruccion==instrucciones.length){
                              id_instruccion=0;
                            }
                            setState(() {
                              texto_instruccion = instrucciones[id_instruccion];
                            });
                          },
                          icon: Icon(
                              Icons.arrow_left,
                              size: 30
                          )
                      )
                  ),
                  Positioned(
                      top: Pantalla.PantallaInstancia.alto-(Pantalla.PantallaInstancia.alto-200)+100,
                      left: Pantalla.PantallaInstancia.ancho/2 -100,
                      child: IconButton(
                          onPressed: () {
                            print(id_instruccion);
                            id_instruccion-=1;
                            if(id_instruccion<0){
                              id_instruccion=instrucciones.length-1;
                            }
                            setState(() {
                              texto_instruccion = instrucciones[id_instruccion];
                            });
                            },
                          icon: Icon(
                              Icons.arrow_left,
                              size: 30
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
