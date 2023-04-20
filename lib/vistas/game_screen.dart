import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/rejilla_juego.dart';

class BreakOutApp extends StatelessWidget {
  const BreakOutApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const titulo = 'Breakout';

    return MaterialApp(
      title: titulo,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              height: 80,
              color: Colors.blueGrey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const <Widget>[
                  Icon(Icons.pause, color: Colors.white, size: 30),
                  Text(
                    "puntos: 0",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "record: 9999",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: RejillaJuego(),
            ),
          ],
        ),
      ),
    );
  }
}
