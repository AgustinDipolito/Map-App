part of 'busqueda_bloc.dart';

@immutable
abstract class BusquedaEvent {}

class OnActivarManual extends BusquedaEvent {}

class OnDesactivarManual extends BusquedaEvent {}

class OnAgregarHistorial extends BusquedaEvent {
  final SearchResult result;

  OnAgregarHistorial(this.result);
}
