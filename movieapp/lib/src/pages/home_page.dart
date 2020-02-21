import 'package:flutter/material.dart';
import 'package:movieapp/src/pages/providers/movies_provider.dart';
import 'package:movieapp/src/pages/search/search_delegate.dart';
import 'package:movieapp/src/pages/widgets/card_swiper_widget.dart';
import 'package:movieapp/src/pages/widgets/movie_horizontal.dart';
class HomePage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopular();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movies on Cinema'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(
                  context: context,
                  delegate: DataSearch(),
//                  query: '',
              );
            },
          )
        ],
      ),
      body: Container(
//        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _cardSwiper(),
            _footer(context)
          ],
        )
      )
    );
  }
  Widget _cardSwiper(){
    return FutureBuilder(
      future: moviesProvider.getOnCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {


        if (snapshot.hasData){
              return CardSwiper(movies: snapshot.data);
        }else{
              return Container(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator()
                )
              );
        }
        
      },
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 25.0),
              child: Text(
                  "Popular", style: Theme.of(context).textTheme.subhead
              )
          ),
          SizedBox(height: 10.0),

          StreamBuilder(
            stream: moviesProvider.popularStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if( snapshot.hasData){
                return MovieHorizontal(
                    movies: snapshot.data,
                    nextPage: moviesProvider.getPopular,
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      )
    );
  }
}
