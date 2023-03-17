import 'package:filmler_uygulamasi_http/Filmler.dart';

class FilmlerCevap{
  int success;
  List<Filmler> filmlerListesi;

  FilmlerCevap(this.success, this.filmlerListesi);

  factory FilmlerCevap.fromJson(Map<String, dynamic> json){
    var jsonArray = json["filmler"] as List;
    List<Filmler> filmlerListesi = jsonArray.map((jsonArrayNesnesi) => Filmler.fromJson(jsonArrayNesnesi)).toList();  // jsonArrayNesnesi ni Filmler sınıfına gönderiyoruz ki parse etsin ve bize film nesnesini aktarsın aynı zamanda Filmler sınıfı composition ile yonetmen ve kategori sınıfına da erişiyor
    // jsonArray de tutulan listeyi filmler sınıfı sayesinde parse edeceğiz ve içerisindeki bütün verilere nesne olarak ulaşacağız ki liste haline dönüştürüp tutacak
    return FilmlerCevap(json["success"] as int, filmlerListesi);
  }
}

// bu sınıf sayesinde film listesine erişmiş oluyoruz