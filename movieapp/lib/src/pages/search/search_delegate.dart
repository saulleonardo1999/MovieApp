import 'package:flutter/material.dart';
import 'package:movieapp/src/pages/models/movie_model.dart';
import 'package:movieapp/src/pages/providers/movies_provider.dart';



class DataSearch extends SearchDelegate{

  Movie select ;


  final moviesProvider = new MoviesProvider();
  final movies = [
    'Spiderman',
    'Iron man',
    'Avengers'
  ];

  final recentMovies = [
    'Xmen',
    'Daredevil',
    'Superman'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro appbar, como un icono para borrar el texto
    
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar como el icono de buscador o de regresar en fb

    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
          close(context, null);
      },

    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // crea los resultados que vamos a mostrar
    return FutureBuilder(
      future: moviesProvider.searchMovie(query) ,
      builder: (BuildContext context, AsyncSnapshot <List<Movie>> snapshot){
        if (snapshot.hasData){
          print(snapshot);
          final movies = snapshot.data;
          return ListView(
              children: movies.map((movie){
                return ListTile(
                  leading: FadeInImage(
                      image: NetworkImage(movie.getPosterImg()),
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      width: 50.0,
                      fit: BoxFit.contain
                  ),
                  title:Text(movie.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(movie.originalTitle,
                    overflow: TextOverflow.ellipsis
                  ),
                  onTap: (){
                    select=movie;
//                    close(context, null);
                    movie.uniqueId ='';

                    Navigator.pushNamed(context, 'detail', arguments: movie);
                  },
                );
              }).toList()
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty){
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie(query) ,
      builder: (BuildContext context, AsyncSnapshot <List<Movie>> snapshot){
        if (snapshot.hasData){
          print(snapshot);
          final movies = snapshot.data;
          return ListView(
            children: movies.map((movie){
              return ListTile(
                leading: FadeInImage(
                    image: NetworkImage(movie.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain
                ),
                title:Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: (){
                  select=movie;
                  close(context, null);
                  movie.uniqueId ='';

                  Navigator.pushNamed(context, 'detail', arguments: movie);
                },
              );
            }).toList()
          );

        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }











//  Widget buildSuggestions(BuildContext context) {
//    // Son las sugerencias que aparecen cuando la persona escribe
//
//    final suggestList = (query.isEmpty)
//                                        ?recentMovies
//                                        :movies.where((p)=>p.toLowerCase().startsWith(query.toLowerCase())
//                                        ).toList();
//    return ListView.builder(
//      itemBuilder: (context, i){
//        return ListTile(
//            leading: Icon(Icons.movie),
//            title: Text(suggestList[i]),
//            onTap:(){
//              select = suggestList[i];
//              showResults(context);
//            }
//        );
//      },
//      itemCount: suggestList.length,
//    );
//  }

}