import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:mapas_app/widgets/widgets.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
            builder: (_, state) {
              return crearMapa(state);
            },
          ),
          MarcadorManual(),
          Positioned(
            top: 15,
            child: SearchBar(),
          ),
        ],
      ),
      floatingActionButton: BtnDialMenu(),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    //estado de carga
    if (!state.existeUbicacion!) return ColEspera(texto: "Ubicando...");

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion!));

    //set camara inical
    final cameraPosition = new CameraPosition(
      target: state.ubicacion!,
      zoom: 15,
    );

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        //mapa en pantalla
        return GoogleMap(
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          compassEnabled: false,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          polylines: mapaBloc.state.polylines!.values.toSet(),
          onMapCreated: mapaBloc.initMapa, // el controller se envia automatico
          onCameraMove: (cameraPosition) {
            mapaBloc.add(OnMovioMapa(cameraPosition.target));
          },
        );
      },
    );
  }
}
