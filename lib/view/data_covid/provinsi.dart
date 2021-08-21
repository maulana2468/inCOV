import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_covid/model/anim_bloc/anim_bloc.dart';
import 'package:info_covid/model/connect_api/connect_api.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class ProvPage extends StatefulWidget {
  const ProvPage({Key? key}) : super(key: key);

  @override
  _ProvPageState createState() => _ProvPageState();
}

class _ProvPageState extends State<ProvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Covid Provinsi",
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
            future: TotalProv.connectToAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TotalProv> dataCovid = snapshot.data as List<TotalProv>;
                return ListView.builder(
                  itemCount: dataCovid.length - 1,
                  itemBuilder: (context, index) {
                    return listCity(
                      context,
                      dataCovid[index].provinsi,
                      dataCovid[index].positif,
                      dataCovid[index].sembuh,
                      dataCovid[index].meninggal,
                      dataCovid[index].dirawat,
                      dataCovid[index].jenisKelamin,
                      dataCovid[index].kelompokUmur,
                      index,
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

Stack listCity(BuildContext context, String city, int pos, int sem, int men,
    int rawat, List jenisKelamin, List kelompokUmur, int indexList) {
  var formatter = NumberFormat('###,###,###,000');

  Map<String, dynamic> jkLk = jenisKelamin[0];
  Map<String, dynamic> jkPr = jenisKelamin[1];
  Map<String, dynamic> kel1 = kelompokUmur[0];
  Map<String, dynamic> kel2 = kelompokUmur[1];
  Map<String, dynamic> kel3 = kelompokUmur[2];
  Map<String, dynamic> kel4 = kelompokUmur[3];
  Map<String, dynamic> kel5 = kelompokUmur[4];
  Map<String, dynamic> kel6 = kelompokUmur[5];

  return Stack(
    children: [
      BlocBuilder<SetAnimBloc, SetAnimState>(
        builder: (context, state) {
          return AnimatedContainer(
            padding: EdgeInsets.only(bottom: 5),
            duration: Duration(milliseconds: 125),
            margin: EdgeInsets.only(bottom: 15),
            width: MediaQuery.of(context).size.width,
            height: (state is SetAnimValue)
                ? ((state.index == indexList) ? 320 : 175)
                : 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
              color: Color(0xffDBE5CD),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 6,
                  //offset: Offset(5, 5),
                )
              ],
            ),
            child: (state is SetAnimValue)
                ? ((state.index == indexList)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Laki-Laki: ",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    formatter
                                        .format(jkLk['doc_count'])
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Perempuan: ",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    formatter
                                        .format(jkPr['doc_count'])
                                        .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(thickness: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Umur 0-5: " +
                                        formatter
                                            .format(kel1['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Umur 6-18: " +
                                        formatter
                                            .format(kel2['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Umur 19-30: " +
                                        formatter
                                            .format(kel3['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Umur 31-45: " +
                                        formatter
                                            .format(kel4['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Umur 46-59: " +
                                        formatter
                                            .format(kel5['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Umur >= 60: " +
                                        formatter
                                            .format(kel6['doc_count'])
                                            .toString(),
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    : null)
                : null,
          );
        },
      ),
      Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 175,
        decoration: BoxDecoration(
          color: Color(0xff0ABDB6),
          borderRadius: BorderRadius.circular(10),
        ),
        //height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              city,
              style: TextStyle(
                fontFamily: "Poppins",
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xffEBE5E5),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dataCovid("Positif: ", Colors.orange, pos),
                      dataCovid("Sembuh: ", Colors.green, sem),
                      dataCovid("Meninggal: ", Colors.red, men),
                      dataCovid("Dirawat: ", Color(0xffC35ee5), rawat),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<SetAnimBloc>().add(Slide(indexList));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text("Info Detail",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 15,
                              )),
                          BlocBuilder<SetAnimBloc, SetAnimState>(
                            builder: (context, state) {
                              return AnimatedContainer(
                                duration: Duration(milliseconds: 130),
                                child: Transform.rotate(
                                  angle: (state is SetAnimValue)
                                      ? ((state.index == indexList)
                                          ? math.pi
                                          : 0)
                                      : 0,
                                  child: Icon(
                                    Icons.arrow_drop_down_circle_outlined,
                                    size: 30,
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Row dataCovid(String dataName, Color color, int value) {
  var formatter = NumberFormat('###,###,###,000');
  return Row(
    children: [
      Text(
        dataName,
        style: TextStyle(
          fontFamily: "Poppins",
          //color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      Text(
        formatter.format(value).toString(),
        style: TextStyle(
          fontFamily: "Poppins",
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      )
    ],
  );
}
