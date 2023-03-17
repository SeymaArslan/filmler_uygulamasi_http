import 'package:filmler_uygulamasi_http/Kategoriler.dart';

class KategorilerCevap{
  int success;
  List<Kategoriler> kategorilerListesi;

  KategorilerCevap(this.success, this.kategorilerListesi);

  factory KategorilerCevap.fromJson(Map<String, dynamic> json){
    var jsonArray = json["kategoriler"] as List;
    List<Kategoriler> kategorilerListesi = jsonArray.map((jsonArrayNesnesi) => Kategoriler.fromJson(jsonArrayNesnesi)).toList(); // jsonArray te tutulan listeyi KAtegoriler sınıfı sayesinde parse edeceğiz
    return KategorilerCevap(json["success"] as int, kategorilerListesi);
  }
}

// bu sınıf sayesinde kategorilerListesini parse etmiş olacağız