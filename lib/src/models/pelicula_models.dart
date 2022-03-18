class Peliculas {

  //INICIALIZAMOS UNA LISTA DE PELICULAS
  List<Pelicula> items = new List();

  //CONSTRUCTOR DE PELICULAS
  Peliculas();


  //RECORREMOS NUESTA PELICULAS Y LA ALMACENAMOS EN UN ITEMS DE LISTA DE PELICULAS
  Peliculas.fromJsonList( List<dynamic> jsonList  ) {


    //SI LA LISTA RETURN NULL, NO REGRESA VALORES
    if ( jsonList == null ) return;

    //RECORREMOS CON UN FOR LA LISTA
    for ( var item in jsonList  ) {
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add( pelicula );
    }

  }

}


//MODELO DE PELICULAS
class Pelicula {

  String uniqueId;

  int voteCount;
  int id;
  bool video;
  double voteAverage;
  String title;
  double popularity;
  String posterPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String backdropPath;
  bool adult;
  String overview;
  String releaseDate;

  Pelicula({
    this.voteCount,
    this.id,
    this.video,
    this.voteAverage,
    this.title,
    this.popularity,
    this.posterPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.backdropPath,
    this.adult,
    this.overview,
    this.releaseDate,
  });


////////////////////////////////////////////////////////////////////////////////////
//INSTANCIAR METODO DE TIPO STRING Y DINAMICO JSON
  Pelicula.fromJsonMap( Map<String, dynamic> json ) {

    voteCount        = json['vote_count'];
    id               = json['id'];
    video            = json['video'];
    //PASAMO EL VALOR A DOUBLE EMTRE 1
    voteAverage      = json['vote_average'] / 1;
    title            = json['title'];
    //PASAMO EL VALOR A DOUBLE ENTRE 1
    popularity       = json['popularity'] / 1;
    posterPath       = json['poster_path'];
    originalLanguage = json['original_language'];
    originalTitle    = json['original_title'];
    //PASAMO EL VALOR DE TIPO ENTERO CAST
    genreIds         = json['genre_ids'].cast<int>();
    backdropPath     = json['backdrop_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
  }
////////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////////
  //IMAGENES  DE PELICULAS POPULARES
  getImagenPopulares() {

    //SI EL VALOR POSTERPATH ES NULL RETORNA UNA IMAGEN POR DEFECTO DESDE INTERNET
    if ( posterPath == null ) {
      return 'https://valmy.com/clubvalmy/wp-content/plugins/smg-theme-tools/public/images/not-available-es.png';
    } else {
      //RETORNA LA IMAGEN DESDE LA API DE PELICULAS
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }

  }
////////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////////
  //IMAGENES DE PELICULAS
  getImagenUrl() {
  //SI EL VALOR POSTERPATH ES NULL RETORNA UNA IMAGEN POR DEFECTO DESDE INTERNET
    if ( posterPath == null ) {
      return 'https://valmy.com/clubvalmy/wp-content/plugins/smg-theme-tools/public/images/not-available-es.png';
    } else {
      //SI NO ES NULL MUESTRA LA IMAGENES DE PELICULAS
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }
////////////////////////////////////////////////////////////////////////////////////





}


