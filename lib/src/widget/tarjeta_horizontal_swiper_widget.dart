import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peli/src/models/pelicula_models.dart';

class TarjetaHorizontal extends StatelessWidget {

  //LISTA DE PELICULAS
  final List<Pelicula> populares;

  //FUNCION  RECIBE LAS SIGUIENTES 20 PELICULAS
  final Function NextPagina;

  TarjetaHorizontal({@required this.populares, @required this.NextPagina});

  //INICIAMOS CON LAS 20 PRIMERA PELICULAS Y FINAL DEL SCROLL
  final _ControlladorPaginas = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );

  @override
  Widget build(BuildContext context) {
    //OBTENEMOS EL ANCHO Y LARGO DEL DISPOSITIVOS
    final _pantallaSize = MediaQuery.of(context).size;

    //COMPARAMOS  SI EL SCROLL LLEGO AL FINAL DE LA LISTA DE PELICULA
    //SI LLEGA AL FINAL AGREGA MAS IMAGENES DE PELICULAS
    _ControlladorPaginas.addListener(() {
      if (_ControlladorPaginas.position.pixels >=
          _ControlladorPaginas.position.maxScrollExtent - 100)
        //AGREGA PELICULAS
        NextPagina();
    });

    return Container(
      height: _pantallaSize.height * 0.25,
   //CREAMOS LA LISTA DE PELICULA CUANDO ES NECESARIO Y NO PERDEMOS MEMORIA
      child: PageView.builder(
        pageSnapping: false,
        controller: _ControlladorPaginas,
        //CREAR UN METODO HORIZONTAL DE PELICULAS POPULARES
        itemCount: populares.length,
        itemBuilder: (context, i) => _tarjeta(context, populares[i]),
      ),
    );
  }

////////////////////////////////////////////////////////////////////////////////////
  Widget _tarjeta(BuildContext context, Pelicula populares) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(populares.getImagenPopulares()),
              placeholder: AssetImage('assets/imagene/camara.jpg'),
              fit: BoxFit.cover,
              height: 160.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            populares.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        //ARGUMENTOS DE PUSNAMED RUTAS
        Navigator.pushNamed(context, 'detalles', arguments: populares);
      },
    );
  }
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //CREAMOS UNA LISTAS DE WIDGET DE PELICULAS POPULARES HORIZONTAL
  List<Widget> _TarjetaHorizonta(BuildContext context) {
    //RECORREMOS EL MAP DE PELICULAS POPULARES
    return populares.map((popular) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                  //MANDAMOS A LLAMAR EL METODO GETIMAGENPOPULARES
                  image: NetworkImage(popular.getImagenPopulares()),
                  placeholder: AssetImage('assets/imagene/camara.jpg'),
                  fit: BoxFit.cover,
                  height: 160.0),
            ),
            Text(
              popular.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      );
    }).toList();
  }
}
////////////////////////////////////////////////////////////////////////////////////