import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peli/src/provider/pelicula_provider.dart';
import 'package:peli/src/widget/tarjeta_horizontal_swiper_widget.dart';
import 'package:peli/src/widget/tarjeta_swiper_widget.dart';

class HomePages extends StatelessWidget {
  PeliculaProvider peliculaProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculaProvider.getDataPopulares();
    return Scaffold(
        appBar: AppBar(
          title: Text('PELICULAS DE CINE'),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.video_collection),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _WidgetSwiperTarjetas(),
              _WidgetPopulares(context)
            ],
          ),
        ));
  }

////////////////////////////////////////////////////////////////////////////////////
  //WIDGET DE TARJETA
  Widget _WidgetSwiperTarjetas() {
    return FutureBuilder(
      future: peliculaProvider.getDataPeliculas(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //VALIDAMOS QUE LOS DATOS NO REGRESE NULL LISTA DE PELICULAS
        if (snapshot.hasData) {
          return TarjetaSwiper(ColeccionPeliculas: snapshot.data);
        } else {
          //SI EL VALOR ES NULL HACE UN LOANDIG O VIENE VACIO
          return Container(
              height: 400.0,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //WIDGET DE PELICULAS POPULARES, MOSTRAMOS TARJET HORIZONTAL INFERIOR
  Widget _WidgetPopulares(BuildContext context) {

    peliculaProvider.getDataPopulares();

    return Container(
      //TOMA EL ANCHO QUE TENGA EL DISPOSITIVOS
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Peliculas Populares',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          //LISTA DE PELICULAS, YA QUE EL FUTUREBUILDER SOLO MUESTRA UNA CANTIDAD ESPECIFICIA
          //STREABUILDER MUESTRA N CANTIDADES
          StreamBuilder(
              //ESCUCHANDO VALORES ENTRANTE
              stream: peliculaProvider.PopularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (snapshot.hasData) {
                  //ENVIAMOS POR REFENCIA  LAS DOS LISTA DE PELICULAS
                  return TarjetaHorizontal(
                    populares: snapshot.data,
                    NextPagina: peliculaProvider.getDataPopulares,
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
////////////////////////////////////////////////////////////////////////////////////