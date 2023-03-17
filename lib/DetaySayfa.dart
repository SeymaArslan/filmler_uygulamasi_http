import 'package:filmler_uygulamasi_http/Filmler.dart';
import 'package:flutter/material.dart';

class DetaySayfa extends StatefulWidget {

  Filmler film;
  DetaySayfa({required this.film});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.film.film_ad),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network("http://localhost/web-services-filmler/fotolar/${widget.film.film_resim}"),
            Text(widget.film.film_yil.toString(), style: TextStyle(fontSize: 30),),
            Text(widget.film.yonetmen.yonetmen_ad.toString(), style: TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }
}
