import 'dart:convert';
import 'package:http/http.dart' as http;

class TotalIndo {
  int positif;
  int meninggal;
  int sembuh;
  int dirawat;

  TotalIndo({
    required this.positif,
    required this.meninggal,
    required this.sembuh,
    required this.dirawat,
  });

  factory TotalIndo.createData(Map<String, dynamic> object) {
    return TotalIndo(
      positif: object['jumlah_positif'],
      meninggal: object['jumlah_meninggal'],
      sembuh: object['jumlah_sembuh'],
      dirawat: object['jumlah_dirawat'],
    );
  }

  static Future<TotalIndo> connectToAPI() async {
    String apiURL = 'https://data.covid19.go.id/public/api/update.json';

    var result = await http.get(Uri.parse(apiURL));
    var resultContent = result.body;
    var jsonObject = json.decode(resultContent);
    var data = (jsonObject as Map<String, dynamic>)['update']['total'];

    return TotalIndo.createData(data);
  }
}

class TotalProv {
  String provinsi;
  int positif;
  int sembuh;
  int meninggal;
  int dirawat;
  List jenisKelamin;
  List kelompokUmur;

  TotalProv({
    required this.provinsi,
    required this.positif,
    required this.sembuh,
    required this.meninggal,
    required this.dirawat,
    required this.jenisKelamin,
    required this.kelompokUmur,
  });

  factory TotalProv.createData(Map<String, dynamic> object) {
    return TotalProv(
      provinsi: object["key"],
      positif: object["jumlah_kasus"],
      sembuh: object["jumlah_sembuh"],
      meninggal: object["jumlah_meninggal"],
      dirawat: object['jumlah_dirawat'],
      jenisKelamin: object['jenis_kelamin'],
      kelompokUmur: object['kelompok_umur'],
    );
  }

  static Future<List<TotalProv>> connectToAPI() async {
    String apiURL = 'https://data.covid19.go.id/public/api/prov.json';

    var result = await http.get(Uri.parse(apiURL));
    var resultContent = result.body;
    var jsonObject = json.decode(resultContent);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['list_data'];

    List<TotalProv> users = [];
    for (var i = 0; i < data.length; i++) {
      users.add(TotalProv.createData(data[i]));
    }

    return users;
  }
}

class Vaksinasi {
  int totalSasaran;
  int smdk;
  int lansia;
  int petugasPublik;
  int vac1;
  int vac2;
  String lastUpdate;

  Vaksinasi({
    required this.totalSasaran,
    required this.smdk,
    required this.lansia,
    required this.petugasPublik,
    required this.vac1,
    required this.vac2,
    required this.lastUpdate,
  });

  factory Vaksinasi.createData(Map<String, dynamic> object) {
    return Vaksinasi(
      totalSasaran: object['totalsasaran'],
      smdk: object['sasaranvaksinsdmk'],
      lansia: object['sasaranvaksinlansia'],
      petugasPublik: object['sasaranvaksinpetugaspublik'],
      vac1: object['vaksinasi1'],
      vac2: object['vaksinasi2'],
      lastUpdate: object['lastUpdate'],
    );
  }

  static Future<Vaksinasi> connectToAPI() async {
    String apiURL = 'https://vaksincovid19-api.vercel.app/api/vaksin';

    var result = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(result.body);
    var data = (jsonObject as Map<String, dynamic>);

    return Vaksinasi.createData(data);
  }
}

class TotalDunia {
  String country;
  int confirmed;
  int death;
  int recovered;
  int active;

  TotalDunia({
    required this.country,
    required this.confirmed,
    required this.death,
    required this.recovered,
    required this.active,
  });

  factory TotalDunia.createData(Map<String, dynamic> object) {
    return TotalDunia(
      country: object['Country_Region'],
      confirmed: object['Confirmed'],
      death: object['Deaths'],
      recovered: (object['Recovered'] != null) ? object['Recovered'] : 0,
      active: (object['Active'] != null) ? object['Active'] : 0,
    );
  }

  static Future<List<TotalDunia>> connectToAPI() async {
    String apiURL = 'https://api.kawalcorona.com/';

    var result = await http.get(Uri.parse(apiURL));
    List jsonObject = json.decode(result.body) as List;

    List<TotalDunia> data = [];
    for (var i = 0; i < 50; i++) {
      var item = (jsonObject[i] as Map<String, dynamic>)['attributes'];
      data.add(TotalDunia.createData(item));
    }

    return data;
  }
}
