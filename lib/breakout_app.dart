import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'vistas/vistas.dart';
import 'modelo/modelo.dart';

class BreakoutApp extends StatelessWidget {
  const BreakoutApp({Key? key}) : super(key: key);

  final titulo = "Brekout";

  @override
  Widget build(BuildContext context) {

    //Que no se pueda girar y que no se vea la barra del so arriba
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return MaterialApp(
        title: titulo,
        theme: ThemeData(
            primarySwatch: Colors.teal
        ),
        home: Scaffold(
            body: SafeArea(
                child: Menu_Principal()
            )
        )
    );
  }
}
