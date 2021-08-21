import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_covid/model/anim_bloc/anim_bloc.dart';
import 'package:info_covid/model/connect_api/connect_rs_api.dart';
import 'dart:math' as math;

import 'package:info_covid/view/cari_rs/cari_rs.dart';

class FindByProv extends StatefulWidget {
  const FindByProv({Key? key}) : super(key: key);

  @override
  _FindByProvState createState() => _FindByProvState();
}

class _FindByProvState extends State<FindByProv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Info Ketersediaan Rumah Sakit",
          style: TextStyle(fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xff55b9d3),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFDFF1F3),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: ProvinsiRS.connectToAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<ProvinsiRS> dataProv = snapshot.data as List<ProvinsiRS>;
                return ListView.builder(
                  itemCount: dataProv.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        listProvRs(
                          context,
                          dataProv[index].id,
                          dataProv[index].name,
                        ),
                      ],
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

Column listProvRs(BuildContext context, String idProv, String nameProv) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        //height: 100,
        decoration: BoxDecoration(
          color: Color(0xff0ABDB6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                nameProv,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                context.read<SetAnim2Bloc>().add(SlideFindProv(idProv));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Kota/Kabupaten",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Divider(),
                  BlocBuilder<SetAnim2Bloc, SetAnimState>(
                    builder: (context, state) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 130),
                        child: Transform.rotate(
                          angle: (state is SetAnim2Value)
                              ? ((state.provId == idProv) ? math.pi : 0)
                              : 0,
                          child: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      BlocBuilder<SetAnim2Bloc, SetAnimState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              margin: EdgeInsets.only(bottom: 15, left: 5),
              width: MediaQuery.of(context).size.width * 0.60,
              decoration: BoxDecoration(
                color: Color(0xffEAF3DD),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    //offset: Offset(1, 1),
                  )
                ],
              ),
              child: (state is SetAnim2Value)
                  ? ((state.provId == idProv)
                      ? FutureBuilder(
                          future: KotaKabRS.connectToAPI(idProv),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<KotaKabRS> dataKotaKab =
                                  snapshot.data as List<KotaKabRS>;
                              return ListView.builder(
                                //scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: dataKotaKab.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: EdgeInsets.all(10),
                                    child: listKotaKab(
                                      context,
                                      dataKotaKab[index].id,
                                      dataKotaKab[index].name,
                                      nameProv,
                                      idProv,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return Align(
                                alignment: Alignment.center,
                                child: LinearProgressIndicator(
                                  minHeight: 10,
                                ),
                              );
                            }
                          },
                        )
                      : null)
                  : null,
            ),
          );
        },
      ),
    ],
  );
}

GestureDetector listKotaKab(BuildContext context, String idKecamatan,
    String kec, String nameProv, String idProv) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  FindByKecamatan(idKecamatan, kec, nameProv, idProv)));
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          kec,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Transform.rotate(
          angle: -(math.pi / 2),
          child: Icon(
            Icons.arrow_drop_down_circle_outlined,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
