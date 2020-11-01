import 'package:flutter/material.dart';

class PasoParametros2 extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final cadena= ModalRoute.of(context).settings.arguments;
    return Container(
      child: Text(cadena),
      
    );
  }
}