import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/anim_bloc/anim_bloc.dart';
import './view/main_menu.dart';
import 'model/api_menu_bloc/api_menu_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String tanggalPref = prefs.getString('tanggal') ?? "-";
  List totalIndoPref =
      prefs.getStringList('datatotalindo') ?? ["-", "-", "-", "-"];
  List vaksinasiPref = prefs.getStringList('datavaksinasi') ??
      ["-", "-", "-", "-", "-", "-", "-"];
  runApp(MyApp(tanggalPref, totalIndoPref, vaksinasiPref));
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String tanggalPref;
  List totalIndoPref;
  List vaksinasiPref;

  MyApp(this.tanggalPref, this.totalIndoPref, this.vaksinasiPref);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SetApiBloc>(create: (context) => SetApiBloc()),
        BlocProvider<SetAnimBloc>(create: (context) => SetAnimBloc()),
        BlocProvider<SetAnim2Bloc>(create: (context) => SetAnim2Bloc()),
      ],
      child: MaterialApp(
        title: "inCOV",
        home: MainMenu(tanggalPref, totalIndoPref, vaksinasiPref),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
