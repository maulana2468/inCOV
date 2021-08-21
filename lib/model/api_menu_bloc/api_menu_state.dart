part of 'api_menu_bloc.dart';

@immutable
abstract class SetApiState {}

class SetApiInitial extends SetApiState {}

class SetApiValue extends SetApiState {
  final TotalIndo data;
  final Vaksinasi data2;
  final String tanggal;

  SetApiValue(this.data, this.data2, this.tanggal);
}
