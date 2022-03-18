import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peli/src/models/pelicula_models.dart';

class DetallesPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController fixedExtentScrollController =
        new FixedExtentScrollController();
   //SE RECIBE  LA LISTA DE PELICULAS POR ARGUMENTO
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(pelicula.title),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent,
      ),
      backgroundColor: Colors.black54,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        //HACEMOS UN SCROLL EN  3D
        child: ListWheelScrollView(
          itemExtent: 280,
          children: [
            //WIDGET
            _DescripcionPeliculas(pelicula),
            _DetallesCompleto(pelicula, context),
            _ImagenPelicula(pelicula),
            _DetallesCompleto(pelicula, context),
            _ImagenPelicula2(pelicula),
          ],
        ),
      ),
    );
  }


////////////////////////////////////////////////////////////////////////////////////
  //WIDGET DE DESCRIPCION
  Widget _DescripcionPeliculas(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      height: 150,
      decoration: BoxDecoration(
          color: Colors.cyanAccent, borderRadius: BorderRadius.circular(15)),
      child: Center(
        //MOSTRAMOS EL TITULO DE LA PELICULA
        child: Text(
          pelicula.overview,
          textAlign: TextAlign.justify,
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //MOTRAMOS LAS IMAGENES DE LA PELICULAS POPULARES
  Widget _ImagenPelicula(Pelicula pelicula) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.cyanAccent, borderRadius: BorderRadius.circular(15)),
      //MOSTRAMOS LA IMAGENE EN UN FADEINMAGE, AL CARGAR MUESTRA UNA FOTO POR DEFECTO
      //LUEGO CARGA LA IMAGEN QUE TRAE DESDE LA API DE PELICULAS
      child: FadeInImage(
        image: NetworkImage(pelicula.getImagenPopulares()),
        placeholder: AssetImage('assets/imagene/camara.jpg'),
        fadeInDuration: Duration(milliseconds: 150),
        fit: BoxFit.cover,
      ),
    );
  }
////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////
  //MOSTRAMOS LAS LISTA DE PELICULAS MAS VOTADA, PROMEDIADA, ENTRE OTRA
  Widget _DetallesCompleto(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      height: 100,
      decoration: BoxDecoration(
        color: Colors.cyanAccent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            pelicula.title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            pelicula.originalTitle,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            width: 10.0,
          ),
          Row(
            children: <Widget>[
              Text('VotoPromedio:  ${pelicula.voteAverage.toString()}'),
              SizedBox(
                width: 5.0,
              ),
              Icon(Icons.how_to_vote_outlined),
            ],
          ),
          Row(
            children: [
              Text('Cantidad de Votos:  ${pelicula.voteCount.toString()}'),
              SizedBox(
                width: 5.0,
              ),
              Icon(Icons.how_to_vote_outlined),
            ],
          ),
          Row(
            children: [
              Text('Popularidad: ${pelicula.popularity.toString()}'),
              SizedBox(
                width: 5.0,
              ),
              Icon(Icons.star),
            ],
          ),
          Row(
            children: [
              Text('Fecha: ${pelicula.releaseDate.toString()}'),
              SizedBox(
                width: 5.0,
              ),
              Icon(Icons.calendar_today_rounded),
            ],
          ),
        ],
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //MOSTRAMOS LA IMAGENES DE LA PELICULAS, MOSTRARIA UNA IMAGEN DIFERENTE
  Widget _ImagenPelicula2(Pelicula pelicula) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          color: Colors.cyanAccent, borderRadius: BorderRadius.circular(15)),
      child: FadeInImage(
        image: NetworkImage(pelicula.getImagenUrl()),
        placeholder: AssetImage('assets/imagene/camara.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////