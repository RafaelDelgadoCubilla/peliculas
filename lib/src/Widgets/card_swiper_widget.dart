import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final peliculas = List<Pelicula>();
  //final List<Pelicula> peliculas;

  CardSwiper({@required peliculas});

  

  @override
  Widget build(BuildContext context) {
    final _screensize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId='${peliculas[index].id}-card';
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
            },
            child: Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(
                    peliculas[index].getPosterImg()
                  ),
                  fit: BoxFit.cover
                ),
              ),
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