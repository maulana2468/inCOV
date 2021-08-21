import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProvinsiRS {
  String id;
  String name;

  ProvinsiRS({required this.id, required this.name});

  factory ProvinsiRS.createData(Map<String, dynamic> object) {
    return ProvinsiRS(
      id: object['id'],
      name: object['name'],
    );
  }

  static Future<List<ProvinsiRS>> connectToAPI() async {
    String apiURL = 'https://rs-bed-covid-api.vercel.app/api/get-provinces';

    var result = await http.get(Uri.parse(apiURL));
    var resultContent = result.body;
    var jsonObject = json.decode(resultContent);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['provinces'];

    List<ProvinsiRS> dataProv = [];
    for (var i = 0; i < data.length; i++) {
      dataProv.add(ProvinsiRS.createData(data[i]));
    }

    return dataProv;
  }
}

class KotaKabRS {
  String id;
  String name;

  KotaKabRS({required this.id, required this.name});

  factory KotaKabRS.createData(Map<String, dynamic> object) {
    return KotaKabRS(
      id: object['id'],
      name: object['name'],
    );
  }

  static Future<List<KotaKabRS>> connectToAPI(String provId) async {
    String apiURL =
        'https://rs-bed-covid-api.vercel.app/api/get-cities?provinceid=$provId';

    var result = await http.get(Uri.parse(apiURL));
    var resultContent = result.body;
    var jsonObject = json.decode(resultContent);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['cities'];

    List<KotaKabRS> dataKotaKab = [];
    for (var i = 0; i < data.length; i++) {
      dataKotaKab.add(KotaKabRS.createData(data[i]));
    }

    return dataKotaKab;
  }
}

class RumahSakit {
  final String id;
  final String name;
  final String address;
  final String phone;
  final int queue;
  final int bedAvailable;
  final String info;

  RumahSakit({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.queue,
    required this.bedAvailable,
    required this.info,
  });

  factory RumahSakit.createData(Map<String, dynamic> object) {
    return RumahSakit(
      id: object['id'] ?? "No data",
      address: object['address'] ?? "No data",
      name: object['name'] ?? "No data",
      phone: object['phone'] ?? "No data",
      queue: object['queue'] ?? 0,
      bedAvailable: object['bed_availability'] ?? 0,
      info: object['info'] ?? "No data",
    );
  }

  static Future<List<RumahSakit>> connectToAPI(
      String idProv, String idKec) async {
    String apiURL =
        'https://rs-bed-covid-api.vercel.app/api/get-hospitals?provinceid=$idProv&cityid=$idKec&type=1';

    var result = await http.get(Uri.parse(apiURL));
    var resultContent = result.body;
    var jsonObject = json.decode(resultContent);
    List<dynamic> data = (jsonObject as Map<String, dynamic>)['hospitals'];

    List<RumahSakit> dataRS = [];
    for (var i = 0; i < data.length; i++) {
      dataRS.add(RumahSakit.createData(data[i]));
    }

    return dataRS;
  }
}
