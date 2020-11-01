import 'package:flutter/material.dart';

class PasoParametros1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paso Parámetros 1')
      ),

      body: _interfaz(context),
    );
  }

  Widget _interfaz(BuildContext context) {
    String cadena;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            onChanged: (valor){
              cadena=valor;
            },
          ),
          FlatButton(
            onPressed: (){
              Navigator.pushNamed(context, 'pasoparametros2', arguments: cadena);
            }, 
            child: Text('Paso de parámetros'),
          )
        ],
      ),
    );
  }
}