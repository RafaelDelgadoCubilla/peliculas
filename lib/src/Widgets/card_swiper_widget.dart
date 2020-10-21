import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {

  final peliculas = List();

  CardSwiper({@required peliculas});

  

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Container(
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network('https://image.tmdb.org/t/p/w600_and_h900_bestv2/j2rf9hrGjm8m1xdH5fy19AcOZ0F.jpg',
              fit: BoxFit.fill,
            ),
          ); 
        },
        //autoplay: true,
        itemCount: peliculas.length,
        //scrollDirection: Axis.vertical,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
        itemWidth: _screensize.width*0.7,
        itemHeight: _screensize.height*0.5,
        layout: SwiperLayout.STACK,
      )
    );
  }
}