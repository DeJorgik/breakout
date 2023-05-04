import 'package:breakout/vistas/vistas.dart';
import 'package:breakout/widgets/pelota.dart';
import 'package:flutter/material.dart';
import 'package:breakout/modelo/modelo.dart';

/*
Vista de la tienda, usa el patron galeria para ver las skins que puedes comprar
 */

class Tienda extends StatefulWidget {
  const Tienda({Key? key}) : super(key: key);

  @override
  State<Tienda> createState() => _TiendaState();
}

class _TiendaState extends State<Tienda> {

  //Lista de items
  final List<Item_Tienda> lista_item_tienda= [
    Item_Tienda(id: 0, color: Colors.white, precio: 0),
    Item_Tienda(id: 0, color: Colors.red, precio: 10),
    Item_Tienda(id: 1, color: Colors.blue, precio: 20),
    Item_Tienda(id: 2, color: Colors.green, precio: 30),
    Item_Tienda(id: 3, color: Colors.yellowAccent, precio: 40),
    Item_Tienda(id: 4, color: Colors.orange, precio: 50),
    Item_Tienda(id: 5, color: Colors.pink, precio: 60),
    Item_Tienda(id: 6, color: Colors.purpleAccent, precio: 70),
    Item_Tienda(id: 7, color: Colors.deepPurple, precio: 80),
    Item_Tienda(id: 8, color: Colors.tealAccent, precio: 90),
    Item_Tienda(id: 9, color: Colors.lightGreenAccent, precio: 100),
    Item_Tienda(id: 10, color: Colors.brown, precio: 110),
    Item_Tienda(id: 11, color: Colors.blueGrey, precio: 120),
    Item_Tienda(id: 12, color: Colors.grey, precio: 130),
    Item_Tienda(id: 13, color: Colors.black, precio: 140),
  ];

  //Color actual
  var color_actual;

  @override
  void initState() {

    lista_item_tienda.forEach((elemento) {
      if(Jugador.JugadorInstancia.record>=elemento.precio) {
        elemento.desbloqueado = true;
      }
    });

    color_actual = Jugador.JugadorInstancia.skin;

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
                        "TIENDA",
                        style:Estilos.EstiloInstancia.titulo2
                      )
                  ),
                  Positioned(
                      top: 75,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Récord: ${Jugador.JugadorInstancia.record}",
                            style: Estilos.EstiloInstancia.texto3
                          ),
                          Estilos.EstiloInstancia.separador,
                          Pelota(
                            color: Jugador.JugadorInstancia.skin,
                          )
                        ],
                      )
                  ),
                  Positioned(
                      top: 110,
                      child: Container(
                          height: Pantalla.PantallaInstancia.alto-215,
                          width: Pantalla.PantallaInstancia.ancho-50,
                          child: GridView.builder(
                            itemCount: lista_item_tienda.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              ),
                            itemBuilder: (context, int index){
                              return Container(
                                child: FloatingActionButton(
                                  backgroundColor: lista_item_tienda[index].desbloqueado ? Colors.white : Colors.grey,
                                  onPressed: () {
                                    //Si el color esta desbloqueado, puedes cambiarlo
                                    if(lista_item_tienda[index].desbloqueado){
                                    Jugador.JugadorInstancia.skin = lista_item_tienda[index].color;

                                    //guardar datos del jugador(nuevo color)
                                    ResourceManager.RM.guardar();

                                    }

                                    //cambiar estado
                                    setState(() {
                                      color_actual = Jugador.JugadorInstancia.skin;
                                    });

                                  },
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Estilos.EstiloInstancia.separador,
                                        Pelota(
                                          color: lista_item_tienda[index].color,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          lista_item_tienda[index].precio.toString(),
                                          style: Estilos.EstiloInstancia.texto3,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              );
                            }
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
                            style: Estilos.EstiloInstancia.texto2
                          )
                      )
                  )
                ]
            )
        ),
    );
  }
}
