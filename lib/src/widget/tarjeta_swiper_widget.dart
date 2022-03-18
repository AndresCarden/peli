import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peli/src/models/pelicula_models.dart';

class TarjetaSwiper extends StatelessWidget {
  final List<Pelicula> ColeccionPeliculas;

  const TarjetaSwiper({this.ColeccionPeliculas});

  @override
  Widget build(BuildContext context) {

    //OBTENEMOS EL ANCHO Y LARGO DEL DISPOSITIVOS
    final _pantallaSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      //SWIPER NO PERMITE CREAR UNA LISTA DE PELICULAS INTERACTIVA
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _pantallaSize.width * 0.7,
        itemHeight: _pantallaSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Container(
                child: Text(ColeccionPeliculas[index].title),
              ),
              //CLIPRRECT REDONDEAMOS LA TARJETAS , IMAGENES
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'detalles',
                      arguments: ColeccionPeliculas[index]),
                  child: FadeInImage(
                    //MOSTRAMOS EL MAPA DE VALORES DE TIPO PELICULAS
                    //TRAEMOS LAS IMAGENES CON EL METODO GETIMAGENURL, LA CUAL TIENE LAS IMAGENES
                    image: NetworkImage(
                      ColeccionPeliculas[index].getImagenUrl(),
                    ),

                    //SI EXISTEN ALGUN PROBLEMA CON ALGUNA IMAGEN DE PELICULA, POR DEFECTO APLICA UNA
                    placeholder: AssetImage('assets/imagene/camara.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          );
        },


        //CANTIDAD DE IMAGEN A MOSTRAR
        itemCount: ColeccionPeliculas.length,
        //pagination: new SwiperPagination(),
        //control: new SwiperControl(),
      ),
    );
  }
}
