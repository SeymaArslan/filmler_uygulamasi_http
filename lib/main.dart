import 'package:filmler_uygulamasi_http/FilmlerSayfa.dart';
import 'package:filmler_uygulamasi_http/Kategoriler.dart';
import 'package:filmler_uygulamasi_http/KategorilerCevap.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Anasayfa(title: 'Flutter Demo Home Page'),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key, required this.title});



  final String title;

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  List<Kategoriler> parseKategorilerCevap(String cevap){
    return KategorilerCevap.fromJson(json.decode(cevap)).kategorilerListesi; // json.decode(cevap) sayesinde
    // cevap ı json formatına dönüştüreceğiz ve KategorilerCevap.fromJson(json.decode(cevap)) burada bize bir nesne gelecek
    // ve gelen bu nesne sayesinde kategorilerListesi ne erişmiş olacağız ve bize parse etmiş olarak bize bir liste dönecek
  }

  Future<List<Kategoriler>> tumKategoriler() async {
    var url = Uri.parse("http://localhost/web-services-filmler/tum_kategoriler.php");
    var cevap = await http.get(url);
    return parseKategorilerCevap(cevap.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kategoriler"),
      ),
      body: FutureBuilder<List<Kategoriler>>(
        future: tumKategoriler(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            var kategoriListesi = snapshot.data;
            return ListView.builder(
              itemCount: kategoriListesi!.length,
              itemBuilder: (context, indeks){
                var kategori = kategoriListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FilmlerSayfa(kategori: kategori )));
                  },
                  child: Card(
                    child: SizedBox( height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(kategori.kategori_ad),
                        ],
                      ),
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
