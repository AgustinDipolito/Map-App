part of 'widgets.dart';

class MarcadorManual extends StatelessWidget {
  const MarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
  const _BuildMarcadorManual({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 100,
          left: 25,
          child: BounceInLeft(
            child: CircleAvatar(
              maxRadius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  BlocProvider.of<BusquedaBloc>(context)
                      .add(OnDesactivarManual());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -10),
            child: BounceInDown(
              child: Icon(
                Icons.location_on,
                size: 35,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 25,
          child: BounceInDown(
            child: MaterialButton(
                minWidth: MediaQuery.of(context).size.width - 150,
                color: Colors.white,
                shape: StadiumBorder(),
                elevation: 5,
                splashColor: Colors.black,
                child: Text("Confirmar"),
                onPressed: () {
                  this.calcularDestino(context);
                }),
          ),
        )
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final inicio = BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
    final destino = BlocProvider.of<MapaBloc>(context).state.ubicacionCentral;

    final trafficResponse =
        await trafficService.getCoordsInicioYDestino(inicio!, destino!);

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;

    //decodificacion puntos geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;

    final List<LatLng> rutaCoords =
        points.map((point) => LatLng(point[0], point[1])).toList();

    BlocProvider.of<MapaBloc>(context)
        .add(OnCrearRutaIniciodestino(rutaCoords, distancia, duracion));

    Navigator.of(context).pop();
    BlocProvider.of<BusquedaBloc>(context).add(OnDesactivarManual());
  }
}
