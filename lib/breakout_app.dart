import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'vistas/vistas.dart';

class BreakoutApp extends StatelessWidget {
  const BreakoutApp({Key? key}) : super(key: key);

  final titulo = "Brekout";

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
