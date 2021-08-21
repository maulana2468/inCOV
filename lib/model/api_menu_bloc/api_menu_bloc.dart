import 'dart:async';

import 'package:flutter/material.dart';
import 'package:info_covid/model/connect_api/connect_api.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'api_menu_event.dart';
part 'api_menu_state.dart';

class SetApiBloc extends Bloc<SetApiEvent, SetApiState> {
  SetApiBloc() : super(SetApiInitial());
  var formatter = NumberFormat('###,###,###,000');

  TotalIndo? totalIndo;
  Vaksinasi? vaksinasi;

  @override
  Stream<SetApiState> mapEventToState(
    SetApiEvent event,
  ) async* {
    if (event is Update) {
      String tanggal = DateFormat('d MMM yyyy hh:mm:ss').format(DateTime.now());
      await TotalIndo.connectToAPI().then((value) => totalIndo = value);
      await Vaksinasi.connectToAPI().then((value) => vaksinasi = value);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('datatotalindo', [
        formatter.format(totalIndo!.positif).toString(),
        formatter.format(totalIndo!.meninggal).toString(),
        formatter.format(totalIndo!.dirawat).toString(),
        formatter.format(totalIndo!.sembuh).toString(),
      ]);
      prefs.setStringList('datavaksinasi', [
        formatter.format(vaksinasi!.totalSasaran).toString(),
        formatter.format(vaksinasi!.smdk).toString(),
        formatter.format(vaksinasi!.lansia).toString(),
        formatter.format(vaksinasi!.petugasPublik).toString(),
        formatter.format(vaksinasi!.vac1).toString(),
        formatter.format(vaksinasi!.vac2).toString(),
        vaksinasi!.lastUpdate.toString(),
      ]);
      prefs.setString('tanggal', tanggal);

      yield SetApiValue(totalIndo!, vaksinasi!, tanggal);
    }
  }
}
