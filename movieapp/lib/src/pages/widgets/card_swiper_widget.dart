import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movieapp/src/pages/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;
  CardSwiper({ @required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;



    return Container(
        padding: EdgeInsets.only(top: 10.0),
//        width: 300.0,
//        height: 300.0,
        child: Swiper(
          layout: SwiperLayout.STACK,
          itemWidth: _screenSize.width * 0.6,
          itemHeight: _screenSize.height * 0.5,
          itemBuilder: (BuildContext context,int index){
            movies[index].uniqueId ="${movies[index].id}-cards";
            return Hero(
              tag: movies[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  child: FadeInImage(           //aqui
                      placeholder: AssetImage('assets/img/no-image.jpg'),
                      image: NetworkImage(movies[index].getPosterImg()),
                      fit: BoxFit.cover
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, 'detail', arguments: movies[index]);
                  },
                )
              ),
            );
          },
          itemCount: movies.length,
//          pagination: new SwiperPagination(),
//          control: new SwiperControl(),
        ));
  }
}
