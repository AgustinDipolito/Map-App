part of "widgets.dart";

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual)
          return Container();
        else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchBar(context),
          );
        }
      },
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: GestureDetector(
          onTap: () async {
            final proximidad =
                BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
            final historial =
                BlocProvider.of<BusquedaBloc>(context).state.historial;
            final resultado = await showSearch(
              context: context,
              delegate: SearchDestination(proximidad!, historial),
            );
            this.retornoBusqueda(resultado!, context);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(75),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Text(
              "Buscar...",
              style: TextStyle(
                color: Colors.black,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(SearchResult result, BuildContext context) async {
    if (result.cancelo) return;
    final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    if (!result.manual) {
      busquedaBloc.add(OnActivarManual());
      return;
    }

    calculandoAlerta(context);

    //calculo ruta de busqueda
    final trafficService = new TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion!;
    final destino = result.position!;
    final drivingResponse =
        await trafficService.getCoordsInicioYDestino(inicio, destino);
    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();

    mapaBloc
        .add(OnCrearRutaIniciodestino(rutaCoordenadas, distancia, duracion));

    Navigator.of(context).pop();

    //actaulizar historial
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}
