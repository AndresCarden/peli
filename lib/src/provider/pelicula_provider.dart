import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import 'package:peli/src/models/pelicula_models.dart';

class PeliculaProvider{

  String _ApiKey = 'a68c8eaf254ed0b606b82826ee546e0f';
  String _Url='api.themoviedb.org';
  String _Language = 'es-ES';

  //NUMERO DE PAGINAS DE PELICULAS A MOSTRAR, SOLO INICIA EN 0 Y HAY N PAGINA
  int _PaginasPopulares = 0;

  bool _CargarPrimeraVeintePagina=false;

  //CREAMOS UNA LISTA DE PELICULAS POPULARES
  List<Pelicula> _PeliculasPopulares = new List();

  //CREAMOS UN STREAM DE DATOS Y LOS ALMACENAMOS, LOS BROADCAST, NOS PERMITE ESCUCHAR POR VARIOS
  final _PopularesStream = StreamController<List<Pelicula>>.broadcast();

  //FUNCIONALIDAD ES AGREGAR PELICULAS
   Function (List<Pelicula>) get PopularesSink=> _PopularesStream.sink.add;


  //ESCUCHAR DATOS
  Stream<List<Pelicula>> get PopularesStream=>_PopularesStream.stream;

  //CERRAMOS EL STREAMCONTROLLER
  void disposeStreamPopulares(){
    _PopularesStream.close();
  }



////////////////////////////////////////////////////////////////////////////////////
  //PROCESAMOS LA LOS DOS METODO COMO SON: getDataPeliculas() Y getDataPopulares()
  Future<List<Pelicula>> _ProcesarDatas(Uri url) async {

    //ESPERA QUE HAGA LA SOLICITUD AWAIT Y OBTENEMOS EL STRING
    final respuesta = await http.get( url );

    //DECODE TOMA EL VALOR STRING Y LOS TRANSFORMA A UN MAPA DE VALORES
    final DataPopulares = json.decode(respuesta.body);



   //OBTENEMOS TODA LA LISTA DE PELICULAS
    final populares = new Peliculas.fromJsonList(DataPopulares['results']);


 //RETORNAMOS LA LISTA DE PELICULAS
    return populares.items;
  }
////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////
  //METODO RETORNA TODA LAS PELICULAS
  Future<List<Pelicula>> getDataPeliculas()async{

    final url = Uri.https(_Url, '3/movie/now_playing', {
      'api_key'  : _ApiKey ,
      'language' : _Language
    });

    return await  _ProcesarDatas(url);

  }
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //METODO RETORNA TODA LAS PELICULAS POPULARES
  Future<List<Pelicula>> getDataPopulares()async{

    //SI ES TRUE RETURN UNA LISTA VACIA
    if(_CargarPrimeraVeintePagina)return[];
    //SI NO HA CARGADO INICIALIZAMOS A TRUE
    _CargarPrimeraVeintePagina=true;

    _PaginasPopulares++;
    //CREAMO LA URL PARA TRAER LAS PELICULAS POPULARES
    final url = Uri.https(_Url, '3/movie/popular',{
      'api_key':_ApiKey,
      'languaje':_Language ,
      'page':_PaginasPopulares.toString(),
    });


   final respuesta = await _ProcesarDatas(url);

   //TENEMOS DOS ITERABLE COMO ES ADD Y ADDALL, LA CUAL ADDALL AGREGA TODA LA PELICULAS
    //MIESTRAS QUE ADD SOLO AGREGA UNA
    _PeliculasPopulares.addAll(respuesta);


    //PASAMO POR REFERENCIA EL ARREGLO DE PELICULAS AL STREAM
    PopularesSink(_PeliculasPopulares);
    //SI YA CARGO LA LISTA, CARGAR ES INICIALIZADO EN FALSE
    _CargarPrimeraVeintePagina=false;

    return respuesta;
  }
////////////////////////////////////////////////////////////////////////////////////






}