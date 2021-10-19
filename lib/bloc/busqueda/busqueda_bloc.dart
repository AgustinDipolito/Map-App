import 'package:bloc/bloc.dart';
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
    }
  }
}
