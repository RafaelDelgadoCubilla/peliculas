import 'package:flutter/material.dart';
import 'package:peliculas/src/Providers/peliculas_provider.dart';
import 'package:peliculas/src/Widgets/card_swiper_widget.dart';
import 'package:peliculas/src/Widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliculasProvider=PeliculasProvider();

  @override
  Widget build(BuildContext context) {
    
    peliculasProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              //showSearch(context: null, delegate: null)
            }
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _swipperTarjetas(),
          _footer(context),
        ],
      )
    );
  }

  Widget _swipperTarjetas() {

    return FutureBuilder(
      future: peliculasProvider.getEncines(),
     //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) return CardSwiper(peliculas: snapshot.data);
        else return Container(
          height: 400.0,
          child: Center(
            child: CircularProgressIndicator()
          )
        );
      },
    );
  }

  Widget _footer(BuildContext context) {
 
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares',style: Theme.of(context).textTheme.subtitle1,)
          ),
          SizedBox(height: 5.0,),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            //initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data,
                  siguientePagina: peliculasProvider.getPopulares,
                );
              }
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
        ],
      ),
    );
  }
}