import 'package:flutter/material.dart';
import 'package:peliculas/src/Widgets/card_swiper_widget.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
      ),
      body: Column(
        children: [
          _swipperTarjetas(),
        ],
      )
    );
  }

  Widget _swipperTarjetas() {

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: 300.0,
      child: CardSwiper(
        peliculas: [1,2,3,4,5]
      )
    );
    
  }
}