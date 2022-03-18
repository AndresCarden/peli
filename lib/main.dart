import 'package:flutter/material.dart';
import 'package:peli/src/pages/detalles_peliculas_pages.dart';
import 'package:peli/src/pages/home_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coleccion de pelicula',
      initialRoute: '/',
      routes: {
        '/':(BuildContext context)=>HomePages(),
       'detalles':(BuildContext context)=>DetallesPages(),

      },
    );
  }
}
