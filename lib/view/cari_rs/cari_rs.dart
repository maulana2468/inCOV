import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:info_covid/model/connect_api/connect_rs_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class FindByKecamatan extends StatefulWidget {
  String idKecamatan;
  String idProv;
  String kecamatan;
  String prov;

  FindByKecamatan(this.idKecamatan, this.kecamatan, this.prov, this.idProv);

  @override
  _FindByKecamatanState createState() =>
      _FindByKecamatanState(idKecamatan, idProv, kecamatan, prov);
}

class _FindByKecamatanState extends State<FindByKecamatan> {
  String idKecamatan;
  String kecamatan;
  String idProv;
  String prov;

  _FindByKecamatanState(
      this.idKecamatan, this.idProv, this.kecamatan, this.prov);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kecamatan,
              style: TextStyle(fontFamily: "Poppins"),
            ),
            Text(
              prov,
              style: TextStyle(fontFamily: "Poppins", fontSize: 17),
            ),
          ],
        ),
        backgroundColor: Color(0xff55b9d3),
        toolbarHeight: 75,
      ),
      body: Container(
        color: Color(0xFFDFF1F3),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Data mungkin terjadi kesalahan\ndikarenakan data pusat sering\nterjadi perubahan!",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: FutureBuilder(
                  future: RumahSakit.connectToAPI(idProv, idKecamatan),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<RumahSakit> dataRS =
                          snapshot.data as List<RumahSakit>;
                      if (dataRS.length != 0) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: dataRS.length,
                          itemBuilder: (context, index) {
                            return listRs(
                              context,
                              index,
                              dataRS[index].id,
                              dataRS[index].name,
                              dataRS[index].address,
                              dataRS[index].bedAvailable,
                              dataRS[index].phone,
                              dataRS[index].queue,
                              dataRS[index].info,
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Rumah sakit tidak ditemukan",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18,
                            ),
                          ),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Container listRs(BuildContext context, int index, String id, String name,
    String address, int bedAvail, String phone, int queue, String info) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Color(0xffC8E3F4),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 6,
          offset: Offset(0, 5),
        ),
      ],
    ),
    padding: EdgeInsets.all(10),
    width: MediaQuery.of(context).size.width,
    //height: 185,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Icon(Icons.location_on),
            ),
            Flexible(
              child: Text(
                address,
                //maxLines: 1,
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Icon(Icons.local_phone),
            ),
            GestureDetector(
              onTap: () async {
                await launch('tel:$phone');
              },
              child: Text(
                phone + " (Kilk untuk Panggilan)",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              child: Icon(Icons.map),
            ),
            GestureDetector(
              onTap: () async {
                String address = await getAddress(id);
                launch(address);
              },
              child: Text(
                "Buka Google Maps",
                style: TextStyle(fontFamily: "Poppins", fontSize: 15),
              ),
            ),
          ],
        ),
        Divider(thickness: 3),
        Text(
          "Antrian: " + queue.toString(),
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
        Text(
          "Tempat tidur tersedia: " + bedAvail.toString(),
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
        Text(
          info,
          style: TextStyle(fontFamily: "Poppins", fontSize: 15),
        ),
      ],
    ),
  );
}

getAddress(String id) async {
  String apiURL =
      'https://rs-bed-covid-api.vercel.app/api/get-hospital-map?hospitalid=$id';

  var result = await http.get(Uri.parse(apiURL));
  var jsonObject = json.decode(result.body);
  String address = (jsonObject as Map<String, dynamic>)['data']['gmaps'];

  return address;
}
