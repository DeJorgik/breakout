import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:breakout/widgets/widgets.dart';
import 'package:breakout/modelo/modelo.dart';

class Pantalla_Juego extends StatelessWidget {
  const Pantalla_Juego({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titulo = 'Breakout';
    return RejillaJuego();
  }
}
