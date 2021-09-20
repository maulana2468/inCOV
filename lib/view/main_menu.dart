import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_covid/model/api_menu_bloc/api_menu_bloc.dart';
import 'package:info_covid/view/cari_rs/cari_provinsi.dart';
import 'package:info_covid/view/data_covid/dunia.dart';
import 'package:intl/intl.dart';
import 'data_covid/provinsi.dart';

// ignore: must_be_immutable
class MainMenu extends StatelessWidget {
  String tanggalPref;
  List totalIndoPref;
  List vaksinasiPref;

  MainMenu(this.tanggalPref, this.totalIndoPref, this.vaksinasiPref);

  var formatter = NumberFormat('###,###,###,000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Image.asset('assets/images/logo.png', scale: 2),
        ),
        backgroundColor: Color(0xffDFF1F3),
        centerTitle: true,
        toolbarHeight: 75,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFDFF1F3),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffb2dfe4),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 7, bottom: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Total Kasus di Indonesia",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: "Poppins",
                                  ),
                                ),
                                BlocBuilder<SetApiBloc, SetApiState>(
                                  builder: (context, state) {
                                    return Text(
                                      state is SetApiValue
                                          ? state.tanggal
                                          : tanggalPref,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Poppins",
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () async {
                                context.read<SetApiBloc>().add(Update());
                                //Future.delayed(Duration(seconds: 5));
                              },
                              child: Icon(
                                Icons.rotate_right,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<SetApiBloc, SetApiState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    lineColumn(
                                      "Positif",
                                      state is SetApiValue
                                          ? formatter
                                              .format(state.data.positif)
                                              .toString()
                                          : totalIndoPref[0],
                                      Colors.orange,
                                    ),
                                    lineColumn(
                                      "Meninggal",
                                      state is SetApiValue
                                          ? formatter
                                              .format(state.data.meninggal)
                                              .toString()
                                          : totalIndoPref[1],
                                      Colors.red,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    lineColumn(
                                      "Dirawat",
                                      state is SetApiValue
                                          ? formatter
                                              .format(state.data.dirawat)
                                              .toString()
                                          : totalIndoPref[2],
                                      Color(0xffC35ee5),
                                    ),
                                    lineColumn(
                                      "Sembuh",
                                      state is SetApiValue
                                          ? formatter
                                              .format(state.data.sembuh)
                                              .toString()
                                          : totalIndoPref[3],
                                      Colors.green,
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                headingTitle("Data Covid Lain"),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    color: Color(0xffb2dfe4),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      locCard(context, ProvPage(), "Provinsi",
                          "assets/images/map.jpg", 0),
                      locCard(context, WorldPage(), "Dunia",
                          "assets/images/map-world.jpg", 1),
                    ],
                  ),
                ),
                headingTitle("Info Ketersediaan Rumah Sakit"),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Color(0xffb2dfe4),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  child: getDataLocButton(
                    context,
                    "Cek Disini",
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindByProv()));
                    },
                    Color(0xffD35045),
                  ),
                ),
                headingTitle("Total Vaksinasi"),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffb2dfe4),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(1, 1),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (rectangle) {
                          return LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ).createShader(Rect.fromLTRB(
                              0, 0, rectangle.width, rectangle.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset('assets/images/vaccine.jpg'),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 5),
                        child: BlocBuilder<SetApiBloc, SetApiState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowVaksinasi(
                                  "Total Sasaran: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.totalSasaran)
                                          .toString()
                                      : vaksinasiPref[0],
                                ),
                                rowVaksinasi(
                                  "Sasaran Vaksin SDMK: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.smdk)
                                          .toString()
                                      : vaksinasiPref[1],
                                ),
                                rowVaksinasi(
                                  "Sasaran Vaksin Lansia: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.lansia)
                                          .toString()
                                      : vaksinasiPref[2],
                                ),
                                rowVaksinasi(
                                  "Sasaran Vaksin Petugas Publik: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.petugasPublik)
                                          .toString()
                                      : vaksinasiPref[3],
                                ),
                                rowVaksinasi(
                                  "Vaksinasi 1: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.vac1)
                                          .toString()
                                      : vaksinasiPref[4],
                                  color: Colors.red.shade800,
                                ),
                                rowVaksinasi(
                                  "Vaksinasi 2: ",
                                  state is SetApiValue
                                      ? formatter
                                          .format(state.data2.vac2)
                                          .toString()
                                      : vaksinasiPref[5],
                                  color: Colors.green.shade800,
                                ),
                                rowVaksinasi(
                                  "Last Update: ",
                                  state is SetApiValue
                                      ? state.data2.lastUpdate.toString()
                                      : vaksinasiPref[6],
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Expanded lineColumn(String stat, String total, Color color) {
  return Expanded(
    child: Column(
      children: [
        Text(
          stat,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Poppins",
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          total,
          style: TextStyle(
            fontSize: 17,
            fontFamily: "Poppins",
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Padding headingTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15, top: 15),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

Container getDataLocButton(
    BuildContext context, String loc, Function() page, Color color) {
  return Container(
    height: 45,
    child: ElevatedButton(
      child: Text(
        loc,
        style: TextStyle(fontSize: 20),
      ),
      onPressed: page,
      style: ElevatedButton.styleFrom(primary: color),
    ),
  );
}

Container rowVaksinasi(String info, String total,
    {color = const Color(0xff000000)}) {
  return Container(
    margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          info,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
          ),
        ),
        Text(
          total,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 17,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}

Container locCard(BuildContext context, Widget func, String nameLoc,
    String assetLoc, int index) {
  return Container(
    padding: EdgeInsets.only(bottom: 10),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => func));
        },
        splashColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                  colors: [Colors.white, Colors.transparent],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(
                    Rect.fromLTRB(0, 0, rectangle.width, rectangle.height));
              },
              blendMode: BlendMode.dstIn,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(assetLoc),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              //height: 140,
              child: Align(
                alignment:
                    (index == 0) ? Alignment.centerRight : Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: (index == 0)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameLoc,
                      style: TextStyle(
                        fontFamily: "poppins",
                        color: (index == 0) ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      (index == 0)
                          ? "data.covid19.go.id"
                          : 'api.kawalcorona.com',
                      style: TextStyle(
                        fontFamily: "poppins",
                        color: (index == 0) ? Colors.black : Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// // ignore: must_be_immutable
// class MainMenu extends StatefulWidget {
//   String tanggalPref;
//   List totalIndoPref;
//   List vaksinasiPref;

//   MainMenu(this.tanggalPref, this.totalIndoPref, this.vaksinasiPref);

//   @override
//   _MainMenuState createState() =>
//       _MainMenuState(tanggalPref, totalIndoPref, vaksinasiPref);
// }

// class _MainMenuState extends State<MainMenu> {
//   String tanggalPref;
//   List totalIndoPref;
//   List vaksinasiPref;

//   _MainMenuState(this.tanggalPref, this.totalIndoPref, this.vaksinasiPref);

//   var formatter = NumberFormat('###,###,###,000');

  