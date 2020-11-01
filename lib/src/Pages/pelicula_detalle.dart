import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peliculas/src/Models/actores_model.dart';
import 'package:peliculas/src/Models/pelicula_model.dart';
import 'package:peliculas/src/Providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula =  ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppbar(pelicula),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10.0,),
                _posterTitulo(context, pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _descripcion(pelicula),
                _crearCasting(pelicula),
              ]
            )
          )
        ],
      )
      
    );
  }

  Widget _crearAppbar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,

      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/img/loading.gif'), 
          image: NetworkImage(pelicula.getBackgroundImg()),
          fadeInDuration: Duration(microseconds: 150),
          fit: BoxFit.cover
        ),
      )
    );
  }

  Widget _posterTitulo(BuildContext context, Pelicula pelicula) {
    return Container(
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 150.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pelicula.title, style: Theme.of(context).textTheme.headline6),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle2),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subtitle2),
                  ],
                )
              ],
            )
          )
        ],
      )
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
      )
    );
  }

  Widget _crearCasting(Pelicula pelicula) {
    final peliculasProvider = PeliculasProvider();
    return FutureBuilder(
      future: peliculasProvider.getCast(pelicula.id.toString()),
      //initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _crearActoresPageView(context, snapshot.data);
        }
        else return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _crearActoresPageView(BuildContext context, List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      /*child: PageView.builder(
        itemCount: actores.length,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _actorTarjeta(actores[index]);
        }
      ),*/
      child: PageView(
        children: _kk(context, actores),
      ),
    );
  }

  Widget _actorTarjeta(BuildContext context, Actor actor) {
    return Text(
      actor.name, 
      style: Theme.of(context).textTheme.headline6,
    );
  }

  List<Widget> _kk(BuildContext context, List<Actor> actores){
    return actores.map( (actor) {
      return _actorTarjeta(context, actor);
    }).toList();
  }

}