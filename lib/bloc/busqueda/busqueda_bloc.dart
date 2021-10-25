import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:mapas_app/models/search_results.dart';
import 'package:meta/meta.dart';

part 'busqueda_event.dart';
part 'busqueda_state.dart';

class BusquedaBloc extends Bloc<BusquedaEvent, BusquedaState> {
  BusquedaBloc() : super(BusquedaState());

  @override
  Stream<BusquedaState> mapEventToState(BusquedaEvent event) async* {
    if (event is OnActivarManual) {
      yield state.copyWith(seleccionManual: true);
    } else if (event is OnDesactivarManual) {
      yield state.copyWith(seleccionManual: false);
    } else if (event is OnAgregarHistorial) {
      yield* this._agregarHistorial(event);
    }
  }

  Stream<BusquedaState> _agregarHistorial(OnAgregarHistorial event) async* {
    final existe = state.historial!
        .where((result) => result.nombreDestino == event.result.nombreDestino)
        .length;
    if (existe == 0) {
      final newHistorial = [...state.historial!, event.result];
      yield state.copyWith(historial: newHistorial);
    }
  }
}
