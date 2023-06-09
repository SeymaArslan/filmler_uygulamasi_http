import 'package:filmler_uygulamasi_http/DetaySayfa.dart';
import 'package:filmler_uygulamasi_http/Filmler.dart';
import 'package:filmler_uygulamasi_http/FilmlerCevap.dart';
import 'package:filmler_uygulamasi_http/Kategoriler.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FilmlerSayfa extends StatefulWidget {

  Kategoriler kategori;
  FilmlerSayfa({required this.kategori});

  @override
  State<FilmlerSayfa> createState() => _FilmlerSayfaState();
}

class _FilmlerSayfaState extends State<FilmlerSayfa> {

  List<Filmler> parseFilmlerCevap(String cevap){
    return FilmlerCevap.fromJson(json.decode(cevap)).filmlerListesi;
  }

  Future<List<Filmler>> filmleriGoster(int kategori_id) async{
    var url = Uri.parse("http://localhost/web-services-filmler/filmler_by_kategori_id.php");
    var veri = {"kategori_id":kategori_id.toString()}; // web serviste bizden göndermemizi beklediği alan "kategori_id" , kategori_id.toString() ise uygulama üzerinde seçtiğimiz veri
    var cevap = await http.post(url, body: veri);
    return parseFilmlerCevap(cevap.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmler : ${widget.kategori.kategori_ad}"),
      ),
      body: FutureBuilder<List<Filmler>>(
        future: filmleriGoster(int.parse(widget.kategori.kategori_id)),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var filmlerListesi = snapshot.data;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                childAspectRatio: 2 / 3.5,
              ),
              itemCount: filmlerListesi!.length,
              itemBuilder: (context, indeks){
                var film = filmlerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(film: film,)));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network("http://localhost/web-services-filmler/fotolar/${film.film_resim}"),
                        ),
                        Text(film.film_ad, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                );
              },
            );
          } else  {
            return Center();
          }
        },
      ),
    );
  }
}
