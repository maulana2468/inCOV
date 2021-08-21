import 'package:flutter/material.dart';
import 'package:info_covid/model/connect_api/connect_api.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({Key? key}) : super(key: key);

  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Data Covid Dunia",
          style: TextStyle(fontFamily: "Poppins"),
        ),
        backgroundColor: Color(0xff55b9d3),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xFFDFF1F3),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: FutureBuilder(
            future: TotalDunia.connectToAPI(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<TotalDunia> dataCovid = snapshot.data as List<TotalDunia>;
                return ListView.builder(
                  itemCount: dataCovid.length,
                  itemBuilder: (context, index) {
                    return listWorld(
                        dataCovid[index].country,
                        dataCovid[index].active,
                        dataCovid[index].confirmed,
                        dataCovid[index].death,
                        dataCovid[index].recovered);
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

Container listWorld(
    String country, int active, int confirmed, int death, int recovered) {
  return Container(
    height: 180,
    padding: EdgeInsets.all(13),
    margin: EdgeInsets.only(bottom: 15),
    decoration: BoxDecoration(
      color: Color(0xffA5E4BA),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            country,
            style: TextStyle(
              fontFamily: "Poppins",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Divider(thickness: 5),
        Container(
          padding: EdgeInsets.all(10),
          height: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              dataCovidWorld("Confirmed: ", confirmed),
              dataCovidWorld("Death: ", death),
              dataCovidWorld("Recovered: ", recovered),
              dataCovidWorld("Active: ", active),
            ],
          ),
        )
      ],
    ),
  );
}

Row dataCovidWorld(String name, int data) {
  return Row(
    children: [
      Text(
        name,
        style: TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(data.toString(),
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)),
    ],
  );
}
