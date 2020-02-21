import 'package:flutter/material.dart';
import 'package:movieapp/src/pages/home_page.dart';
import 'package:movieapp/src/pages/movie_detail.dart';

void main() => runApp(MovieApp());

class MovieApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieApp',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context) => HomePage(),
        'detail' : (BuildContext context) => MovieDetail(),
      },
    );
  }
}
