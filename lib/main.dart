import 'package:flutter/material.dart';
import 'package:peliculas/src/Pages/home_page.dart';
import 'package:peliculas/src/Pages/paso_parametros1.dart';
import 'package:peliculas/src/Pages/paso_parametros2.dart';
import 'package:peliculas/src/Pages/pelicula_detalle.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detalle' : (BuildContext context) => PeliculaDetalle(),
        'pasoparametros1' : (BuildContext context) => PasoParametros1(),
        'pasoparametros2' : (BuildContext context) => PasoParametros2(),
      },
    );
  }
}